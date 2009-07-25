//
//  FlickrJSONResponse.m
//

#import "FlickrJSONResponse.h"
#import "SearchResult.h"
#import "JSON/JSON.h"

@implementation FlickrJSONResponse

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // Parse the JSON data that we retrieved from the server.
    NSDictionary *json = [responseBody JSONValue];
    [responseBody release];
    
    // Drill down into the JSON object to get the parts
    // that we're actually interested in.
    NSDictionary *root = [json objectForKey:@"photos"];
    totalObjectsAvailableOnServer = [[root objectForKey:@"total"] integerValue];

    // Now wrap the results from the server into a domain-specific object.
    NSArray *results = [root objectForKey:@"photo"];
    for (NSDictionary *rawResult in results) {
        
        SearchResult *result = [[[SearchResult alloc] init] autorelease];
        result.bigImageURL = [rawResult objectForKey:@"url_m"];
        result.thumbnailURL = [rawResult objectForKey:@"url_t"];
        result.title = [rawResult objectForKey:@"title"];
        result.bigImageSize = CGSizeMake([[rawResult objectForKey:@"width_m"] floatValue],
                                         [[rawResult objectForKey:@"height_m"] floatValue]);

        [self.objects addObject:result];
    }
    
    return nil;
}

- (NSString *)format { return @"json"; }

@end
