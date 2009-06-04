//
//  YahooJSONResponse.m
//

#import "YahooJSONResponse.h"
#import "JSON/JSON.h"

@implementation YahooJSONResponse

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // parse the JSON data that we retrieved from the server
    NSDictionary *json = [responseBody JSONValue];
    [responseBody release];
    
    // drill down into the JSON object to get the part 
    // that we're actually interested in.
    NSDictionary *resultSet = [json objectForKey:@"ResultSet"];
    NSArray *results = [resultSet objectForKey:@"Result"];
    
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
    
    return nil;
}

@end
