//
//  TableAsyncDataSource.h
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@class WebService;

//
//      TableAsyncDataSource
//
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
