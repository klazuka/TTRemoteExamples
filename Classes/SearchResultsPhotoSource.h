//
//  SearchResultsPhotoSource.h
//
//  Created by Keith Lazuka on 5/29/09.
//  
//

#import "Three20/Three20.h"

@protocol SearchResultsModel;

/*
 *      SearchResultsPhotoSource
 *      ------------------------
 *
 *  Responsibilities:
 *      - Load photos from the Internet (this responsibility is delegated to
 *        the YahooSearchResultsModel via Objective-C forwarding).
 *      - Vend TTPhoto instances to the photo browsing system.
 *      - Tell the photo browsing system how many photos in total
 *        are available on the server.
 *
 *  The TTPhotoSource protocol entails that you must also conform to the TTModel protocol.
 *  Since we already have a useful TTModel in this demo app (YahooSearchResultsModel)
 *  we do not want to reinvent the wheel here. Hence, I will just forward the TTModel
 *  interface to the underlying model object.
 *
 */
@interface SearchResultsPhotoSource : NSObject <TTPhotoSource>
{
    id<SearchResultsModel> *model;
    
    // Backing storage for TTPhotoSource properties.
    NSString *albumTitle;
    int totalNumberOfPhotos;    
}

- (id)initWithModel:(id<SearchResultsModel>)theModel;    // Designated initializer.

- (id<SearchResultsModel>)underlyingModel;     // The model to which this PhotoSource forwards in order to conform to the TTModel protocol.

@end
