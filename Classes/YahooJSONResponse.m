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
    
    // Drill down into the JSON object to get the parts
    // that we're actually interested in.
    NSDictionary *resultSet = [json objectForKey:@"ResultSet"];
    totalObjectsAvailableOnServer = [[resultSet objectForKey:@"totalResultsAvailable"] integerValue];

    // Now wrap the results from the server into a domain-specific object.
    NSArray *results = [resultSet objectForKey:@"Result"];
    for (NSDictionary *rawResult in results) {
        SearchResult *result = [[[SearchResult alloc] init] autorelease];
        result.title = [rawResult objectForKey:@"Title"];
        result.bigImageURL = [rawResult objectForKey:@"Url"];
        result.thumbnailURL = [rawResult valueForKeyPath:@"Thumbnail.Url"];
        result.bigImageSize = CGSizeMake([[rawResult objectForKey:@"Width"] intValue], 
                                         [[rawResult objectForKey:@"Height"] intValue]);
        [self.objects addObject:result];
    }
    
    return nil;
}

@end
