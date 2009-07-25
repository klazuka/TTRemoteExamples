//
//  FlickrXMLResponse.m
//

#import "FlickrXMLResponse.h"
#import "SearchResult.h"
#import "DDXMLDocument.h"

@implementation FlickrXMLResponse

/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTURLResponse

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
    NSError *error = nil;
    
    // Parse the XML document.
    DDXMLDocument *doc = [[[DDXMLDocument alloc] initWithData:data options:0 error:&error] autorelease];
    NSAssert(doc, @"Failed to parse XML. The document is nil.");
    DDXMLElement *root = [doc rootElement];

    // Query the XML tree according to the Flickr image search API specification.
    NSArray *titles = [root nodesForXPath:@"//photo/@title" error:&error];
    NSArray *bigImageURLs = [root nodesForXPath:@"//photo/@url_m" error:&error];
    NSArray *bigImageWidths = [root nodesForXPath:@"//photo/@width_m" error:&error];
    NSArray *bigImageHeights = [root nodesForXPath:@"//photo/@height_m" error:&error];
    NSArray *thumbnailURLs = [root nodesForXPath:@"//photo/@url_t" error:&error];
    totalObjectsAvailableOnServer = [[[[root nodesForXPath:@"//photos/@total" error:&error] lastObject] stringValue] integerValue];
    
    NSAssert1(!error, @"XML Parse error: %@", error);
    NSAssert([titles count] == [bigImageURLs count] && [titles count] == [thumbnailURLs count], 
             @"XPath error: the quantity of the data retrieved does not match.");
    
    // Now construct our domain-specific object.
    for (NSUInteger i = 0; i < [titles count]; i++) {
        SearchResult *result = [[[SearchResult alloc] init] autorelease];
        result.title = [[titles objectAtIndex:i] stringValue];
        result.bigImageURL = [[bigImageURLs objectAtIndex:i] stringValue];
        result.thumbnailURL = [[thumbnailURLs objectAtIndex:i] stringValue];
        result.bigImageSize = CGSizeMake([[[bigImageWidths objectAtIndex:i] stringValue] intValue], 
                                         [[[bigImageHeights objectAtIndex:i] stringValue] intValue]);
        [self.objects addObject:result];
    }
    
    return nil;
}

- (NSString *)format { return @"rest"; }

@end
