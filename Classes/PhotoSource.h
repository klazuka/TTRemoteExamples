//
//  PhotoSource.h
//  Three20RemotePhotos
//
//  Created by Keith Lazuka on 5/29/09.
//  
//

#import "Three20/Three20.h"

@class YahooSearchResultsModel;

@interface PhotoSource : NSObject <TTPhotoSource>
{
    // The TTPhotoSource protocol entails that you must also conform to the TTModel protocol.
    // Since we already have a useful TTModel in this demo app (YahooSearchResultsModel)
    // we do not want to reinvent the wheel here. Hence, I will just forward the TTModel
    // interface to the underlying model object.
    YahooSearchResultsModel *model;
    
    // Backing storage for TTPhotoSource properties.
    NSString *albumTitle;
    int totalNumberOfPhotos;    
}

- (id)initWithModel:(YahooSearchResultsModel *)theModel;    // Designated initializer.

- (id<TTModel>)underlyingModel;     // The model to which this PhotoSource forwards in order to conform to the TTModel protocol.

@end
