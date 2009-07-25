//
//  FlickrSearchResultsModel.m
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "FlickrSearchResultsModel.h"
#import "FlickrJSONResponse.h"
#import "FlickrXMLResponse.h"
#import "GTMNSDictionary+URLArguments.h"
#import "App.h"

const static NSUInteger kFlickrBatchSize = 16;   // The number of results to pull down with each request to the server.

@implementation FlickrSearchResultsModel

@synthesize searchTerms;

- (id)initWithResponseFormat:(SearchResponseFormat)responseFormat;
{
    if ((self = [super init])) {
        switch ( responseFormat ) {
            case SearchResponseFormatJSON:
                responseProcessor = [[FlickrJSONResponse alloc] init];
                break;
            case SearchResponseFormatXML:
                responseProcessor = [[FlickrXMLResponse alloc] init];
                break;
            default:
                [NSException raise:@"SearchResponseFormat unknown!" format:nil];
        }
        page = 1;
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
        page++;
    else
        [responseProcessor.objects removeAllObjects]; // Clear out data from previous request.
    
    NSString *batchSize = [NSString stringWithFormat:@"%lu", (unsigned long)kFlickrBatchSize];
    
    // Construct the request.
    NSString *host = @"http://api.flickr.com";
    NSString *path = @"/services/rest/";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"flickr.photos.search", @"method",
                                searchTerms, @"text",
                                @"url_m,url_t", @"extras",
                                @"43f122b1a7fef3db2328bd75b38da08d", @"api_key", // TODO comment this out
                                [responseProcessor format], @"format",
                                [NSString stringWithFormat:@"%lu", (unsigned long)page], @"page",
                                batchSize, @"per_page",
                                @"1", @"nojsoncallback",
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
    page = 1;
    [[responseProcessor objects] removeAllObjects];
}

- (void)setSearchTerms:(NSString *)theSearchTerms
{
    if (![theSearchTerms isEqualToString:searchTerms]) {
        [searchTerms release];
        searchTerms = [theSearchTerms retain];
        page = 1;
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
