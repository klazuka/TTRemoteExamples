//
//  TableAsyncDataSource.h
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@class WebService;

/*
 *      TableAsyncDataSource
 *
 *  I designed this class so that it does not need to be sub-classed.
 *  Who knows whether this is a good idea or not. I figured it was 
 *  worth trying.
 *
 *  The basic idea is that whatever logic you would have implemented
 *  by overriding load:nextPage: in this class, you provide as data
 *  contained in the WebService object. The goal is to make it easier
 *  for client code to do basic stuff like sending a search query
 *  to a web service and displaying the response. Another benefit 
 *  of this separation is that the client doesn't need to worry
 *  about calling the data source lifecycle methods 
 *  (e.g. dataSourceDidStartLoad, dataSourceDidFinishLoad).
 *
 *  If this separation of responsibility doesn't work for you, please
 *  feel free to do it the old fashioned way by subclassing TTListDataSource.
 *  If you do decide to subclass TTListDataSource, I would recommend 
 *  factoring out the TTLoadable responsibility and data source
 *  lifecycle methods into a separate base class.
 *
 */
@interface TableAsyncDataSource : TTListDataSource <TTURLRequestDelegate>
{
    WebService *webService;
    BOOL isActive;
    NSInteger numberOfItemsInServerRecordset;           // part of the auto-magic system for enabling the "Load More Items" button at the bottom of the tableview.
    
    // TTLoadable support
    NSDate *lastLoadedTime;
    BOOL isLoading;
    BOOL isLoadingMore;
}

@property (nonatomic, retain) WebService *webService;   // the object that manages sending the request to the server
@property (nonatomic, assign) BOOL isActive;            // defaults to YES. When set to NO, the load:nextPage: method will do nothing. The idea is that sometimes you don't have the datasource entirely configured before its tableview is displayed. In these cases, set isActive to NO at instantiation, and then set it to YES once it is fully configured.

@end
