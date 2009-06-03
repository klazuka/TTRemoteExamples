//
//  TableAsyncJSONDataSource.m
//

#import "TableAsyncJSONDataSource.h"
#import "JSON/JSON.h"

@implementation TableAsyncJSONDataSource

/////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (void)load:(TTURLRequestCachePolicy)cachePolicy nextPage:(BOOL)nextPage
{
    // send the request to Yahoo's image search service
    // (note that we are requesting JSON output)
    static NSString *url = @"http://search.yahooapis.com/ImageSearchService/V1/imageSearch?appid=YahooDemo&query=lolcats&output=json";
    TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
    request.cachePolicy = cachePolicy;
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
    request.httpMethod = @"GET";
    [request send];
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// TTURLRequestDelegate

- (void)requestDidStartLoad:(TTURLRequest*)request
{
    [self dataSourceDidStartLoad];
}

- (void)requestDidFinishLoad:(TTURLRequest*)request
{
    TTURLDataResponse *response = request.response;
    NSString *responseBody = [[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding];
    
    // parse the JSON data that we retrieved from the server
    NSDictionary *json = [responseBody JSONValue];
    [responseBody release];
    
    // drill down into the JSON object to get the part 
    // that we're actually interested in.
    NSDictionary *resultSet = [json objectForKey:@"ResultSet"];
    NSArray *results = [resultSet objectForKey:@"Result"];
    
    // remove any previous items
    [self.items removeAllObjects];
    
    // now wrap the results from the server into an object
    // that Three20's tableview system can natively display
    // (in this case, it is a TTIconTableField).
    for (NSDictionary *result in results) {     
        [self.items addObject:[[[TTIconTableField alloc]
                                initWithText:[result objectForKey:@"Title"]
                                url:nil
                                image:[result objectForKey:@"Url"]
                                defaultImage:[UIImage imageNamed:@"DefaultAlbum.png"]] autorelease]];
    }
    
    [self dataSourceDidFinishLoad];
}

- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error
{
    [self dataSourceDidFailLoadWithError:error];
}

- (void)requestDidCancelLoad:(TTURLRequest*)request
{
    [self dataSourceDidCancelLoad];
}



@end
