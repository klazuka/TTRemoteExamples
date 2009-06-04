//
//  YahooViewController.m
//

#import "YahooViewController.h"
#import "TableAsyncDataSource.h"
#import "WebService.h"
#import "YahooJSONResponse.h"
#import "YahooXMLResponse.h"

// constants specific to the Yahoo Image Search web service
static const int kYahooResultsPerQuery = 16;
static const int kYahooMaxNumPhotos = 1000;

//  Un-comment the appropriate line to switch between
//  the XML data source and the JSON data source implementation.
#define YAHOO_OUTPUT_FORMAT @"json"
//#define YAHOO_OUTPUT_FORMAT @"xml"

// maps keys (NSString - string response format) to values (Class - response format implementations)
static const NSDictionary *kResponseFormatToClassMapping;

@implementation YahooViewController

+ (void)initialize
{
    kResponseFormatToClassMapping = [[NSDictionary alloc] 
                                     initWithObjectsAndKeys:
                                     [YahooXMLResponse class], @"xml", 
                                     [YahooJSONResponse class], @"json",
                                     nil];
}

+ (TableItemsResponse *)responseForFormat:(NSString *)format
{
    Class klass = [kResponseFormatToClassMapping objectForKey:[format lowercaseString]];
    NSAssert1(klass != nil, @"YahooViewController dataSourceForFormat: %@ is an unknown format", format);
    
    return [[[klass alloc] init] autorelease];
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewController

- (id<TTTableViewDataSource>)createDataSource
{
    // instantiate the data source and configure it to use either the XML or JSON
    // response processor, depending on how the YAHOO_OUTPUT_FORMAT symbol is defined.
    
    TableAsyncDataSource *myDataSource = [[[TableAsyncDataSource alloc] init] autorelease];
    
    myDataSource.isActive = NO; // since we don't know the search query terms yet, disable the datasource.
    
    // instantiate a WebService object so that the datasource knows how to talk to the server.
    WebService *service = [[[WebService alloc] init] autorelease];
    service.hostname = @"search.yahooapis.com";
    service.path = @"/ImageSearchService/V1/imageSearch";
    service.httpMethod = @"GET";
    service.recordsetStartKey = @"start"; // per Yahoo Image Search API
    
    // arguments to be appended to the URL (or, TODO in the future, the HTTP body once the data source supports POST method).
    // notice that the Yahoo "query" parameter is not specified here because the user has not specified the search terms yet.
    // this argument/key will be set to the appropriate value as soon as the user presses the search button.
    service.parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"YahooDemo", @"appid",
                            [NSString stringWithFormat:@"%d", kYahooResultsPerQuery], @"results",
                            YAHOO_OUTPUT_FORMAT, @"output",
                            nil];
    
    // instantiate the object that will translate the HTTP response into a list of table items.
    service.responseProcessor = [[self class] responseForFormat:YAHOO_OUTPUT_FORMAT];
    
    myDataSource.webService = service;
    return myDataSource;
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

/////////////////////////////////////////////////////////////////////////////////////
#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    TableAsyncDataSource *myDataSource = (TableAsyncDataSource*)self.dataSource;
    [myDataSource.webService.parameters setObject:[searchBar text] forKey:@"query"];    // TODO this is ugly (Law of Demeter)
    [myDataSource setIsActive:YES];     // ensure that the data source is enabled since the search query has now been specified.
    [myDataSource invalidate:YES];      // reset lastLoadedTime and clear out the list of items
    [myDataSource load:TTURLRequestCachePolicyAny nextPage:NO];
}

@end
