//
//  YahooSearchResultsModel.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "YahooSearchResultsModel.h"
#import "YahooJSONResponse.h"
#import "YahooXMLResponse.h"
#import "GTMNSDictionary+URLArguments.h"

//
//  Un-comment the appropriate line below to switch between
//  the XML data source and the JSON data source implementation.
//
static NSString *kOutputFormat = @"json";
//static NSString *kOutputFormat = @"xml";

const static NSUInteger kYahooBatchSize = 16;   // The number of results to pull down with each request to the server.

@implementation YahooSearchResultsModel

@synthesize searchTerms;

- (id)init
{
    if ((self = [super init])) {
        responseProcessor = [kOutputFormat isEqualToString:@"json"] 
                                ? [[YahooJSONResponse alloc] init] 
                                : [[YahooXMLResponse alloc] init];
    }
    return self;
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
                                kOutputFormat, @"output",
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
    return [[responseProcessor objects] copy];
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
