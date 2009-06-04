//
//  TableItemsResponse.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 6/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TableItemsResponse.h"

@implementation TableItemsResponse

@synthesize items;
@synthesize numberOfItemsInServerRecordset;

- (id)init
{
    if ((self = [super init])) {
        items = [[NSMutableArray alloc] init];
        numberOfItemsInServerRecordset = 0;
    }
    return self;
}

- (void)dealloc
{
    [items release];
    [super dealloc];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTURLResponse

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
    NSAssert(NO, @"TableItemsResponse is an abstract class. Sub-classes must implement request:processResponse:data:");
    return nil;
}

@end