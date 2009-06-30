//
//  YahooViewController.h
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"

//
//      YahooViewController
//      ------------------------
//
//  This view controller manages a UITableView that will
//  display Yahoo image search results. 
//
//  The controller uses a datasource object to asynchronously
//  query the Yahoo service, fetch the results and parse it 
//  into a format that the tableview can display.
//
//  You should use this class as an example of how you would
//  subclass TTTableViewController to display results from
//  whatever web service you need to connect to.
//
//  NOTE: this class relies on a "WebService" object to provide
//        all of the information that TableAsyncDataSource needs
//        to perform queries and to automatically enable the
//        "load more results" button at the bottom of the table.
//
@interface YahooViewController : TTTableViewController <UISearchBarDelegate>
{
}

@end

