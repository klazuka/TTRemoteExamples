//
//  TableAsyncViewController.h
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "TableAsyncDataSource.h"

//
//      TableAsyncViewController
//      ------------------------
//
//  This view controller manages a UITableView that will
//  display Yahoo image search results. 
//
//  The controller uses a datasource object to asynchronously
//  query the Yahoo service, fetch the results and parse it 
//  into a format that the tableview can display.
//
//  There are 2 datasources used here:
//
//      1) jsonDataSource 
//              - an instance of TableAsyncJSONDataSource
//              - sends 'lolcats' search query to Yahoo
//
//      2) xmlDataSource
//              - an instance of TableAsyncXMLDataSource
//              - sends 'beach' search query to Yahoo
//
//  Obviously, hardcoded search queries have limited utility
//  in a real application. I tried to make this controller
//  and the data sources as simple as possible for educational
//  purposes. In a real application, your datasource subclass
//  would provide an interface for the controller to change
//  the search query, record offset, etc.
//
@interface TableAsyncViewController : TTTableViewController
{
    TableAsyncDataSource *jsonDataSource;
    TableAsyncDataSource *xmlDataSource;
}

@end

