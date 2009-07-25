//
//  SearchTableViewController.m
//

#import "SearchTableViewController.h"
#import "SearchResultsTableDataSource.h"
#import "App.h"

@implementation SearchTableViewController

- (id)init
{
    if ((self = [super init])) {
        self.title = @"Table Example";
        
        // Initialize our TTTableViewDataSource and our TTModel.
        id<TTTableViewDataSource> ds = [SearchResultsTableDataSource dataSourceWithItems:nil];
        ds.model = CreateSearchModelWithCurrentSettings();
        
        // By setting the dataSource property, the model property for this
        // class (SearchTableViewController) will automatically be hooked up 
        // to point at the same model that the dataSource points at, 
        // which we just instantiated above.
        self.dataSource = ds;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIViewController

- (void)loadView
{
    // Create the tableview.
    self.view = [[[UIView alloc] initWithFrame:TTApplicationFrame()] autorelease];
    self.tableView = [[[UITableView alloc] initWithFrame:TTApplicationFrame() style:UITableViewStylePlain] autorelease];
    self.tableView.rowHeight = 80.f;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    // Add search bar to top of screen.
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
    // Configure our TTModel with the user's search terms
    // and tell the TTModelViewController to reload.
    [searchBar resignFirstResponder];
    [self.model setSearchTerms:[searchBar text]]; // TODO I guess I'm going to need to create a model base class, or at least a protocol.
    [self reload];
    [self.tableView scrollToTop:YES];
}

@end
