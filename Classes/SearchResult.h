//
//  SearchResult.h
//  Three20TableAsync
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "Three20/Three20.h"

/*
 *      SearchResult
 *
 *  A domain-specific object that represents a single result
 *  from a search query. When the user performs a search,
 *  the TTModel will be loaded with a list of these 'SearchResult'
 *  objects.
 *
 *  This class conforms to the TTPhoto protocol as a convenience
 *  so that you can use instances of this class directly in 
 *  a TTPhotoSource. If you are only interested in this app's
 *  table support (and not the TTPhoto/ThumbsViewController stuff)
 *  then you can get rid of the TTPhoto stuff from this class.
 *
 *  If this app
 *  were a complex, real-world app, then it might not be a good
 *  idea to fold in the TTPhoto interface into this class,
 *  but since we're just providing example code, I think it is
 *  justified.
 *
 */
@interface SearchResult : NSObject <TTPhoto>
{
    // Basic data
    NSString *title;
    NSString *imageURL;
    NSString *thumbnailURL;
    
    // TTPhoto conformance
    id <TTPhotoSource> photoSource;
    CGSize size;
    NSInteger index;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *thumbnailURL;

@end
