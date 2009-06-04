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
}

@property (nonatomic, retain) NSMutableArray *items;

@end
