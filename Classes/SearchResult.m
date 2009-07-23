//
//  SearchResult.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 7/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchResult.h"


@implementation SearchResult

@synthesize title, imageURL;

+ (SearchResult *)searchResultFromDictionary:(NSDictionary *)dictionary
{
    SearchResult *result = [[[SearchResult alloc] init] autorelease];
    result.title = [dictionary objectForKey:@"Title"];
    result.imageURL = [dictionary objectForKey:@"Url"];
    return result;
}

- (void)dealloc
{
    [title release];
    [imageURL release];    
    [super dealloc];
}

@end
