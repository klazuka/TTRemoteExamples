//
//  URLModelResponse.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 6/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "URLModelResponse.h"

@implementation URLModelResponse

@synthesize objects;

+ (id)response
{
    return [[[[self class] alloc] init] autorelease];
}

- (id)init
{
    if ((self = [super init])) {
        objects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [objects release];
    [super dealloc];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTURLResponse

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
    NSAssert(NO, @"URLModelResponse is an abstract class. Sub-classes must implement request:processResponse:data:");
    return nil;
}

@end