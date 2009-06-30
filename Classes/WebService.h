//
//  WebService.h
//  Three20TableAsync
//
//  Created by Keith Lazuka on 6/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@class TableItemsResponse;

@interface WebService : NSObject
{
    NSString *hostname;
    NSString *path;
    NSMutableDictionary *parameters;
    NSString *recordsetStartKey;
    TableItemsResponse *responseProcessor;
    NSString *httpMethod;
}

@property (nonatomic, retain) NSString *hostname;                           // REQUIRED. The hostname of the webservice (e.g. "search.yahooapis.com")
@property (nonatomic, retain) NSString *path;                               // optional. defaults to "/". The path component of the web service's URL (e.g. "/" or "/foo/bar/baz")
@property (nonatomic, retain) NSMutableDictionary *parameters;              // optional. key/value pairs to send either encoded in the URL (if httpMethod is GET) or form-encoded in the body (if httpMethod is POST).
@property (nonatomic, retain) NSString *recordsetStartKey;                  // optional. the key for parameters to update with the offset of the first record to pull in the next request.
@property (nonatomic, retain) TableItemsResponse *responseProcessor;        // REQUIRED. an object that will process the HTTP response into a list of items suitable for display in a TTListDataSource/TableView combo.
@property (nonatomic, retain) NSString *httpMethod;                         // optional. defaults to "GET". The other possible value is "POST".

- (void)fetchItemsFromIndex:(NSInteger)fromIndex cachePolicy:(TTURLRequestCachePolicy)cachePolicy delegate:(id<TTURLRequestDelegate>)delegate;  // send an asynchronous request to the server

@end