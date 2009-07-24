//
//  SearchResult.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 7/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchResult.h"


@implementation SearchResult

@synthesize title, imageURL, thumbnailURL;

- (void)dealloc
{
    [title release];
    [imageURL release];
    [thumbnailURL release];
    [super dealloc];
}

@end
