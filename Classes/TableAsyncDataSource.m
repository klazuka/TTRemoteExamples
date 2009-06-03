//
//  TableAsyncDataSource.m
//

#import "TableAsyncDataSource.h"
#import "TableAsyncJSONDataSource.h"
#import "TableAsyncXMLDataSource.h"
#import "GTMNSDictionary+URLArguments.h"

static const int kYahooResultsPerQuery = 16;
static const int kYahooMaxNumPhotos = 1000;

static const NSDictionary *kResponseFormatToClassMapping;   // maps keys (NSString - string response format types to values Class 

@implementation TableAsyncDataSource

@synthesize query;

+ (void)initialize
{
    kResponseFormatToClassMapping = [[NSDictionary alloc] 
                                     initWithObjectsAndKeys:
                                        [TableAsyncXMLDataSource class], @"xml", 
                                        [TableAsyncJSONDataSource class], @"json",
                                        nil];
}

+ (id)dataSourceForFormat:(NSString *)format
{
    Class klass = [kResponseFormatToClassMapping objectForKey:[format lowercaseString]];
    NSAssert1(klass != nil, @"TableAsyncDataSource dataSourceForFormat: %@ is an unknown format", format);
    
    return [[[klass alloc] init] autorelease];
}

- (void)setQuery:(NSString *)theQuery
{
    if (query != theQuery) {
        // set the property
        [query release];
        query = [theQuery retain];
        
        // remove any photos from a previous query
        [self.items removeAllObjects];
        
        // ensure that the PhotoSource is now marked as "outdated"
        [lastLoadedTime release];
        lastLoadedTime = [[NSDate distantPast] retain];
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewDataSource

- (void)load:(TTURLRequestCachePolicy)cachePolicy nextPage:(BOOL)nextPage
{
    if (!query)
        return;
    
    // calculate the offset into the recordset to be retrieved
    int start = nextPage ? [self.items count] + 1 : 1;
    
    // lookup this data source's desired output format to receive from the Yahoo web service.
    NSArray *formats = [kResponseFormatToClassMapping allKeysForObject:[self class]];
    NSAssert([formats count] == 1, @"TableAsyncDataSource: ERROR the response format dictionary must be a 1-to-1 mapping from format types to classes."); 
    NSString *outputFormat = [formats objectAtIndex:0];
    NSAssert(outputFormat, @"TableAsyncDataSource: ERROR could not determine the web service's desired output format.");
    
    // arguments to the Yahoo Image Search API
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"YahooDemo", @"appid",
                          query, @"query",
                          [NSString stringWithFormat:@"%d", kYahooResultsPerQuery], @"results",
                          [NSString stringWithFormat:@"%d", start], @"start",
                          outputFormat, @"output",
                          nil];
    
    // send the request to Yahoo
    NSString *url = [NSString stringWithFormat:
                     @"http://search.yahooapis.com/ImageSearchService/V1/imageSearch?%@",
                     [args gtm_httpArgumentsString]];
    
    TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
    request.cachePolicy = cachePolicy;
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
    request.httpMethod = @"GET";
    [request send];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTLoadable

- (NSDate*)loadedTime
{
    return lastLoadedTime;
}

- (BOOL)isLoading
{
    return isLoading;
}

- (BOOL)isLoadingMore
{
    return isLoadingMore;
}

- (BOOL)isLoaded
{
    return lastLoadedTime != nil;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTDataSource

- (void)dataSourceDidStartLoad
{
    isLoading = YES;
    [super dataSourceDidStartLoad];
}

- (void)dataSourceDidFinishLoad
{
    isLoading = NO;
    isLoadingMore = NO;
    [lastLoadedTime release];
    lastLoadedTime = [[NSDate date] retain];
    [super dataSourceDidFinishLoad];
}

- (void)dataSourceDidFailLoadWithError:(NSError*)error
{
    TTLOG(@"TableAsyncDataSource dataSourceDidFailLoadWithError:%@", [error description]);
    isLoading = NO;
    isLoadingMore = NO;
    [super dataSourceDidFailLoadWithError:error];
}

- (void)dataSourceDidCancelLoad
{
    TTLOG(@"TableAsyncDataSource dataSourceDidCancelLoad");
    isLoading = NO;
    isLoadingMore = NO;
    [super dataSourceDidCancelLoad];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -

- (void) dealloc
{
    [lastLoadedTime release];
    [super dealloc];
}


@end
