//
//  TableAsyncDataSource.h
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

//
//      TableAsyncDataSource
//
//  A base class for retrieving data from the Yahoo Image Search
//  web service.
//
//  Clients of this class should use the dataSourceForFormat:
//  factory method to acquire a concrete dataSource implementation.
//
//  When the client is ready to search, it should set the |query|
//  property to the search string that will be sent to Yahoo
//  and then call the load:nextPage: method on the client's
//  TTTableViewController instance.
//
//  NOTE TO SUB-CLASSERS: it is the subclass's responsibility
//  to call these lifecycle methods on self at the appropriate time:
//
//    - (void)dataSourceDidStartLoad
//    - (void)dataSourceDidFinishLoad
//    - (void)dataSourceDidFailLoadWithError:
//    - (void)dataSourceDidCancelLoad
//
//  Sub-classers must also add their format/class pair to the 
//  dictionary of available response formats managed by this base class.
//
@interface TableAsyncDataSource : TTListDataSource <TTURLRequestDelegate>
{
    NSString *query;
    
    // TTLoadable support
    NSDate *lastLoadedTime;
    BOOL isLoading;
    BOOL isLoadingMore;
}

@property (nonatomic, retain) NSString *query;  // the search query to send to Yahoo

+ (id)dataSourceForFormat:(NSString *)format;   // factory method to construct data sources based on the type of the response from the web service. Currently, |format| can either be "xml" or "json"

@end
