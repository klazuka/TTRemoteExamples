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
 *        the SearchResultsModel implementation via Objective-C forwarding).
 *      - Vend TTPhoto instances to the photo browsing system.
 *      - Tell the photo browsing system how many photos in total
 *        are available on the server.
 *
 *  The TTPhotoSource protocol entails that your implementation must also conform to the 
 *  TTModel protocol. Since we already have a useful TTModel in this demo app
 *  (YahooSearchResultsModel and FlickrSearchResultsModel) we want to reuse those objects. Hence,
 *  I will just forward the TTModel interface to the underlying model object. Unfortunately,
 *  this is easier said than done, as there are several places in the Three20 codebase
 *  where it uses object identity to determine whether to respond to an event. In the case
 *  where an object such as this photo source is forwarding the TTModel interface to another
 *  object, these object identity tests will fail unless precautions are taken. Please
 *  see ForwardingAdapters.h for the workaround.
 *
 *  This forwarding hack would not be necessary if Three20 had finished the decoupling
 *  of remote datasource and the "datasource" that feeds the UI. TTModel is a nice abstraction,
 *  but I believe it is incomplete, particularly with respect to TTPhotoSource. The whole reason
 *  that TTModel exists is to allow one remote datasource to be used in multiple UI contexts,
 *  but as you can see from this demo app, it is difficult to make a clean separation.
 *  The problem is that TTPhotoSource practically begs to be a subclass of TTURLRequestModel,
 *  but if you were to rely on inheritance here, you would be once again conflating the
 *  remote datasource and the datasource that feeds the UI, thereby defeating the whole purpose
 *  of the TTModel abstraction.
 *
 *  In summary, until TTPhotoSource's relationship with TTModel is cleaned up, the best way
 *  to separate the remote datasource from the way that it is presented is to do something
 *  like the runtime forwarding that I do here. If, however, you only need to display the
 *  data from the remote datasource using a single UI component (e.g. just in the photo browser,
 *  without any need to display it in a table view), then you can get rid of the forwarding
 *  and just make your SearchResultsModels also implement the TTPhotoSource protocol. Of course,
 *  if you go that route, you are throwing away whatever advantages the TTModel abstraction
 *  can provide to your application's architecture.
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
