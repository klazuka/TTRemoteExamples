//
//  TableItemsResponse.h
//  Three20TableAsync
//
//  Created by Keith Lazuka on 6/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface TableItemsResponse : NSObject <TTURLResponse>
{
    NSMutableArray *items;
    int numberOfItemsInServerRecordset;
}

@property (nonatomic, retain) NSMutableArray *items;                // intended to be read-only for clients, read-write for sub-classes
@property (nonatomic, assign) int numberOfItemsInServerRecordset;   // intended to be read-only for clients, read-write for sub-classes

@end
