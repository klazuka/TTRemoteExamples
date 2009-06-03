//
//  TableAsyncDataSource.h
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

//
//      TableAsyncDataSource
//
//  Generic data source for a simple table list
//  where the data is loaded from the Internet.
//
//  It is your subclass's responsibility to call these
//  lifecycle methods on self at the appropriate time:
//
//    - (void)dataSourceDidStartLoad
//    - (void)dataSourceDidFinishLoad
//    - (void)dataSourceDidFailLoadWithError:
//    - (void)dataSourceDidCancelLoad
//
@interface TableAsyncDataSource : TTListDataSource <TTURLRequestDelegate>
{
    NSDate *lastLoadedTime;
    BOOL isLoading;
    BOOL isLoadingMore;
}

@end
