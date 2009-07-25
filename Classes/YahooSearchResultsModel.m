//
//  YahooSearchResultsModel.m
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "YahooSearchResultsModel.h"
#import "YahooJSONResponse.h"
#import "YahooXMLResponse.h"
#import "GTMNSDictionary+URLArguments.h"
#import "App.h"

const static NSUInteger kYahooBatchSize = 16;   // The number of results to pull down with each request to the server.

@implementation YahooSearchResultsModel

@synthesize searchTerms;

- (id)initWithResponseFormat:(SearchResponseFormat)responseFormat;
{
    if ((self = [super init])) {
        switch ( responseFormat ) {
            case SearchResponseFormatJSON:
                responseProcessor = [[YahooJSONResponse alloc] init];
                break;
            case SearchResponseFormatXML:
                responseProcessor = [[YahooXMLResponse alloc] init];
                break;
            default:
                [NSException raise:@"SearchResponseFormat unknown!" format:nil];
        }
    }
    return self;
}

- (id)init
{
    return [self initWithResponseFormat:CurrentSearchResponseFormat];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (!searchTerms) {
        TTLOG(@"No search terms specified. Cannot load the model resource.");
        return;
    }
    
    if (more)
        recordOffset += kYahooBatchSize;
    else
        [responseProcessor.objects removeAllObjects]; // Clear out data from previous request.
    
    NSString *offset = [NSString stringWithFormat:@"%lu", (unsigned long)recordOffset];
    NSString *batchSize = [NSString stringWithFormat:@"%lu", (unsigned long)kYahooBatchSize];
    
    // Construct the request.
    NSString *host = @"http://search.yahooapis.com";
    NSString *path = @"/ImageSearchService/V1/imageSearch";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                searchTerms, @"query",
                                @"YahooDemo", @"appid",
                                [responseProcessor format], @"output",
                                offset, @"start",
                                batchSize, @"results",
                                nil];
            
    NSString *url = [host stringByAppendingFormat:@"%@?%@", path, [parameters gtm_httpArgumentsString]];
    TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
    request.cachePolicy = cachePolicy;
    request.response = responseProcessor;
    request.httpMethod = @"GET";
    
    // Dispatch the request.
    [request send];
}

- (void)reset
{
    [super reset];
    [searchTerms release];
    searchTerms = nil;
    recordOffset = 0;
    [[responseProcessor objects] removeAllObjects];
}

- (void)setSearchTerms:(NSString *)theSearchTerms
{
    if (![theSearchTerms isEqualToString:searchTerms]) {
        [searchTerms release];
        searchTerms = [theSearchTerms retain];
        recordOffset = 0;
    }
}

- (NSArray *)results
{
    return [[[responseProcessor objects] copy] autorelease];
}

- (NSUInteger)totalResultsAvailableOnServer
{
    return [responseProcessor totalObjectsAvailableOnServer];
}

- (void)dealloc
{
    [searchTerms release];
    [responseProcessor release];
    [super dealloc];
}


@end
