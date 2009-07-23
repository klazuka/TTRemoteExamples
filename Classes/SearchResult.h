//
//  SearchResult.h
//  Three20TableAsync
//
//  Created by Keith Lazuka on 7/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *      SearchResult
 *
 *  A domain-specific object that represents a single result
 *  from a search query. When the user performs a search,
 *  the TTModel will be loaded with a list of these 'SearchResult'
 *  objects.
 *
 */
@interface SearchResult : NSObject
{
    NSString *title;
    NSString *imageURL;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *imageURL;

+ (SearchResult *)searchResultFromDictionary:(NSDictionary *)dictionary;

@end
