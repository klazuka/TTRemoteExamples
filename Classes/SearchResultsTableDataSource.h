//
//  SearchResultsTableDataSource.h
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "Three20/Three20.h"

/*
 *      SearchResultsTableDataSource
 *      -----------
 *
 *  Responsibilities:
 *      - Vend data objects that can be used by TTTableViewController.
 *
 *  The TTTableViewDataSource protocol specifies a few additional
 *  responsibilities, but since I'm subclassing TTListDataSource,
 *  there is no need to discuss them here. If you're interested
 *  please look at the TTTableViewDataSource protocol definition.
 *
 *  In simple cases, or during early prototyping, you would just 
 *  vend TTTableItems, but as your app becomes more sophisticated
 *  you may want to vend your own objects. If you do choose to vend
 *  your own objects, then you need to implement tableView:cellClassForObject:
 *  to provide your UITableViewCell subclass that knows how to render
 *  your data object and you need to implement 
 *  tableView:cell:willAppearAtIndexPath: to configure your custom cell
 *  to match the state of your data object.
 *
 */
@interface SearchResultsTableDataSource : TTListDataSource
{

}

@end
