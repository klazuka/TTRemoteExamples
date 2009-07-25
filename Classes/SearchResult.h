//
//  SearchResult.h
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "Three20/Three20.h"

/*
 *      SearchResult
 *      ------------
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
    NSString *bigImageURL;
    NSString *thumbnailURL;
    CGSize bigImageSize;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *bigImageURL;
@property (nonatomic, retain) NSString *thumbnailURL;
@property (nonatomic, assign) CGSize bigImageSize;

@end
