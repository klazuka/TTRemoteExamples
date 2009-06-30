//
//  TableItemsResponse.h
//  Three20TableAsync
//
//  Created by Keith Lazuka on 6/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

/*
 *      TableItemsResponse
 *
 *  An abstract base class for HTTP response parsers
 *  that extracts the total number of items available
 *  on the server and exposes that number in order
 *  to support the data source's automatic 
 *  "load more items" feature.
 *
 *  Your subclass is responsible for parsing an HTTP
 *  response into a list of items that will then 
 *  be used as the objects in a TTTableViewController's
 *  data source.
 *
 *  Your subclass is also responsible for extracting
 *  the total number of items available on the server
 *  and setting that value to the 
 *  |numberOfItemsInServerRecordset| property.
 *
 */
@interface TableItemsResponse : NSObject <TTURLResponse>
{
    NSMutableArray *items;
    int numberOfItemsInServerRecordset;
}

@property (nonatomic, retain) NSMutableArray *items;                // Intended to be read-only for clients, read-write for sub-classes
@property (nonatomic, assign) int numberOfItemsInServerRecordset;   // Intended to be read-only for clients, read-write for sub-classes

@end
