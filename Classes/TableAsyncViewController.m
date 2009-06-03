//
//  TableAsyncViewController.m
//

#import "TableAsyncViewController.h"
#import "TableAsyncJSONDataSource.h"
#import "TableAsyncXMLDataSource.h"

static NSString *kTableAsyncLolcatsJSON = @"lolcats JSON";
static NSString *kTableAsyncBeachXML = @"beach XML";

@implementation TableAsyncViewController

- (id)init
{
    if ((self = [super init])) {
        
        self.title = @"Async TableView";
        
        // these datasources will send a GET request to Yahoo's image search API
        jsonDataSource = [[TableAsyncJSONDataSource alloc] init];   // search query will be 'lolcats'
        xmlDataSource = [[TableAsyncXMLDataSource alloc] init];     // search query will be 'beach'
    }
    return self;
}

- (void)loadView
{
    // create the tableview
    self.view = [[[UIView alloc] initWithFrame:TTApplicationFrame()] autorelease];
    self.tableView = [[[UITableView alloc] initWithFrame:TTApplicationFrame() style:UITableViewStylePlain] autorelease];
    self.tableView.rowHeight = 80.f;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // create the segment control so that you can switch
    // between the example JSON and XML data sources
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 44.f)];
    header.backgroundColor = [UIColor whiteColor];
    UISegmentedControl *segments = [[UISegmentedControl alloc] initWithItems:
                                    [NSArray arrayWithObjects:kTableAsyncLolcatsJSON, kTableAsyncBeachXML, nil]];
    segments.selectedSegmentIndex = 0;
    segments.frame = CGRectInset(header.frame, 10.f, 4.f);
    [segments addTarget:self
                 action:@selector(switchDataSource:)
       forControlEvents:UIControlEventValueChanged];
    [header addSubview:segments];
    self.tableView.tableHeaderView = header;
    [header release];
    
    // embed the tableview in the view managed by this controller
    [self.view addSubview:self.tableView];  
}

- (void)switchDataSource:(id)sender
{
    NSString *selectedTitle = [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]];
    
    if ([selectedTitle isEqualToString:kTableAsyncLolcatsJSON]) {
        self.dataSource = jsonDataSource;
        
    } else if ([selectedTitle isEqualToString:kTableAsyncBeachXML]) {
        self.dataSource = xmlDataSource;
        
    } else {
        TTLOG(@"-[TableAsyncViewController switchDataSource:] Unknown datasource segment: %@", selectedTitle);
        return;
    }
    
    [[(TableAsyncDataSource*)self.dataSource items] removeAllObjects];
    [self reloadContent];
}

- (id<TTTableViewDataSource>)createDataSource
{
    return jsonDataSource;
}

- (UIImage*)imageForError:(NSError*)error
{
  return [UIImage imageNamed:@"Three20.bundle/images/error.png"];
}

@end
