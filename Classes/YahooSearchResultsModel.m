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
    
    // Construct the request.
    NSString *host = @"http://search.yahooapis.com";
    NSString *path = @"/ImageSearchService/V1/imageSearch";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                searchTerms, @"query",
                                @"YahooDemo", @"appid",
                                kOutputFormat, @"output",
                                nil];
            
    NSString *url = [host stringByAppendingFormat:@"%@?%@", path, [parameters gtm_httpArgumentsString]];
    TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
    request.cachePolicy = cachePolicy;
    request.response = responseProcessor;
    request.httpMethod = @"GET";
    
    // Clear out old data.
    [responseProcessor.objects removeAllObjects];
    
    // Dispatch the request.
    [request send];
}

- (NSArray *)results
{
    return [[responseProcessor objects] copy];
}

- (void)dealloc
{
    [searchTerms release];
    [responseProcessor release];
    [super dealloc];
}


@end
