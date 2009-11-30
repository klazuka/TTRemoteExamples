//
//  ForwardingAdapters.h
//  TTRemoteExamples
//
//  Created by Keith Lazuka on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Three20/Three20.h"

/*
 *  HACK:
 *
 *      The TTModel system does not expect that your TTPhotoSource implementation
 *      is actually forwarding to another object that implements the TTModel aspect
 *      of the TTPhotoSource protocol. So we must ensure that the TTModelViewController's
 *      notion of what its model is matches the object that it will receive
 *      via the TTModelDelegate messages.
 */

@class SearchResultsPhotoSource;

@interface MyPhotoViewController : TTPhotoViewController
{
	id <TTModel> realModel;
}
@property (nonatomic,retain) id <TTModel> realModel;
@end


@interface MyThumbsViewController : TTThumbsViewController
{
	id <TTModel> realModel;
}
- (id)initForPhotoSource:(SearchResultsPhotoSource *)source;
@end


@interface MyThumbsDataSource : TTThumbsDataSource
{}
@end
