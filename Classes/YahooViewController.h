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
@interface YahooViewController : TTTableViewController <UISearchBarDelegate>
{
}

@end

