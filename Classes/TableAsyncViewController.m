//
//  TableAsyncViewController.m
//

#import "TableAsyncViewController.h"
#import "TableAsyncDataSource.h"

//
//  Un-comment the appropriate line to switch between
//  the XML data source and the JSON data source implementation.
//
#define YAHOO_OUTPUT_FORMAT @"json"
//#define YAHOO_OUTPUT_FORMAT @"xml"


@implementation TableAsyncViewController

////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewController

- (id<TTTableViewDataSource>)createDataSource
{
    // instantiate either the XML or JSON data source (see the #defines at the top of this file)
    return [TableAsyncDataSource dataSourceForFormat:YAHOO_OUTPUT_FORMAT];
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIViewController

- (void)loadView
{
    // create the tableview
    self.view = [[[UIView alloc] initWithFrame:TTApplicationFrame()] autorelease];
    self.tableView = [[[UITableView alloc] initWithFrame:TTApplicationFrame() style:UITableViewStylePlain] autorelease];
    self.tableView.rowHeight = 80.f;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    // add search bar to top of screen
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.f, 0.f, TTApplicationFrame().size.width, TOOLBAR_HEIGHT)];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [searchBar release];
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTViewController

- (UIImage*)imageForError:(NSError*)error
{
    return [UIImage imageNamed:@"Three20.bundle/images/error.png"];
}

////////////////////////////////////////////////////////////////////////
#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Searching for %@", [searchBar text]);
    [searchBar resignFirstResponder];
    [(TableAsyncDataSource*)self.dataSource setQuery:[searchBar text]];
    [self.dataSource load:TTURLRequestCachePolicyAny nextPage:NO];
}

@end
