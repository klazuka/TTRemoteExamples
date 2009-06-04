//
//  WebService.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 6/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WebService.h"
#import "TableItemsResponse.h"
#import "GTMNSDictionary+URLArguments.h"

@implementation WebService

@synthesize hostname;
@synthesize path;
@synthesize parameters;
@synthesize recordsetStartKey;
@synthesize responseProcessor;
@synthesize httpMethod;

- (id)init
{
    if ((self = [super init])) {
        self.path = @"/";
        self.parameters = [NSMutableDictionary dictionary];
        self.httpMethod = @"GET";
    }
    return self;
}

- (void)requestItemsFromIndex:(NSInteger)fromIndex cachePolicy:(TTURLRequestCachePolicy)cachePolicy delegate:(id<TTURLRequestDelegate>)delegate
{
    if (self.recordsetStartKey) {
        [self.parameters setObject:[NSString stringWithFormat:@"%d", fromIndex] forKey:self.recordsetStartKey];
    } else {
        NSLog(@"WebService - Ignoring fromIndex because recordsetStartKey is nil.");
    }

    NSMutableString *fullUrl = [NSMutableString stringWithFormat:@"http://%@%@", self.hostname, self.path];
    
    // if it is a GET request, and there are parameters, append the URL-encoded parameters to the query part of the URL
    if ([[self.httpMethod uppercaseString] isEqualToString:@"GET"] && [self.parameters count] > 0)
        [fullUrl appendFormat:@"?%@", [self.parameters gtm_httpArgumentsString]];            
    
    TTURLRequest *request = [TTURLRequest requestWithURL:fullUrl delegate:delegate];
    request.cachePolicy = cachePolicy;
    request.response = self.responseProcessor;
    request.httpMethod = self.httpMethod;
    
    // if it is a POST request, dump the parameters into the request (which will put them in the HTTP body)
    if ([[self.httpMethod uppercaseString] isEqualToString:@"POST"])
        [request.parameters addEntriesFromDictionary:self.parameters];

    // dispatch the request
    NSLog(@"WebService sending request fromIndex:%d to %@ using responseProcessor:%@", fromIndex, fullUrl, self.responseProcessor);
    [request send];    
}

- (void)dealloc
{
    [hostname release];
    [path release];
    [parameters release];
    [recordsetStartKey release];
    [responseProcessor release];
    [httpMethod release];
    [super dealloc];
}


@end