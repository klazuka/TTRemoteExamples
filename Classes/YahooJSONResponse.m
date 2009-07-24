//
//  YahooJSONResponse.m
//

#import "YahooJSONResponse.h"
#import "SearchResult.h"
#import "JSON/JSON.h"

@implementation YahooJSONResponse

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // Parse the JSON data that we retrieved from the server.
    NSDictionary *json = [responseBody JSONValue];
    [responseBody release];
    
    // Drill down into the JSON object to get the part 
    // that we're actually interested in.
    NSDictionary *resultSet = [json objectForKey:@"ResultSet"];
    NSArray *results = [resultSet objectForKey:@"Result"];
    
    // Now wrap the results from the server into a domain-specific object.
    for (NSDictionary *rawResult in results) {
        SearchResult *result = [[[SearchResult alloc] init] autorelease];
        result.title = [rawResult objectForKey:@"Title"];
        result.imageURL = [rawResult objectForKey:@"Url"];
        result.thumbnailURL = [rawResult valueForKeyPath:@"Thumbnail.Url"];
        [self.objects addObject:result];
    }
    
    return nil;
}

@end
