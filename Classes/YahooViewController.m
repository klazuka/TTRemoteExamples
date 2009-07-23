//
//  YahooViewController.m
//

#import "YahooViewController.h"
#import "YahooSearchResultsModel.h"
#import "SearchResultsTableDataSource.h"

@implementation YahooViewController

- (id)init
{
    if ((self = [super init])) {
        id<TTTableViewDataSource> ds = [SearchResultsTableDataSource dataSourceWithItems:nil];
        ds.model = [[[YahooSearchResultsModel alloc] init] autorelease];
        self.dataSource = ds;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIViewController

- (void)loadView
{
    // Create the tableview
    self.view = [[[UIView alloc] initWithFrame:TTApplicationFrame()] autorelease];
    self.tableView = [[[UITableView alloc] initWithFrame:TTApplicationFrame() style:UITableViewStylePlain] autorelease];
    self.tableView.rowHeight = 80.f;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    // Add search bar to top of screen
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.f, 0.f, TTApplicationFrame().size.width, TT_ROW_HEIGHT)];
    searchBar.delegate = self;
    searchBar.placeholder = @"Image Search";
    self.navigationItem.titleView = searchBar;
    [searchBar release];
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTViewController

- (UIImage*)imageForError:(NSError*)error
{
    return [UIImage imageNamed:@"Three20.bundle/images/error.png"];
}

/////////////////////////////////////////////////////////////////////////////////////
#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [(YahooSearchResultsModel*)self.model setSearchTerms:[searchBar text]];
    [self reload];
}

@end
