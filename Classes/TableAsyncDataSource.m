//
//  TableAsyncDataSource.m
//

#import "TableAsyncDataSource.h"
#import "TableItemsResponse.h"
#import "WebService.h"

@implementation TableAsyncDataSource

@synthesize webService;
@synthesize isActive;

- (id)init
{
    if ((self = [super init])) {
        isActive = YES;
        numberOfItemsInServerRecordset = -1;
    }
    return self;
}

- (BOOL)hasMoreToLoad
{
    return [self.items count] < numberOfItemsInServerRecordset;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewDataSource

- (void)load:(TTURLRequestCachePolicy)cachePolicy nextPage:(BOOL)nextPage
{
    if (!isActive) {
        NSLog(@"TableAsyncDataSource is not active so I will ignore this request to load:nextPage:");
        return;
    }

    NSAssert(self.webService, @"TableAsyncDataSouce cannot load:nextPage: when the webService property is nil.");
    
    // calculate the offset into the recordset to be retrieved
    NSInteger start = nextPage ? [self.items count] + 1 : 1;
    
    // send the asynchronous request to the web service
    [self.webService requestItemsFromIndex:start cachePolicy:cachePolicy delegate:self];
    
    isLoadingMore = start > 0;
}

- (id)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row == [tableView numberOfRowsInSection:0]-1 && self.hasMoreToLoad) {
        // Vend the "Load More Items" button if this is the last row AND there is more data on the server.
        NSString* title = TTLocalizedString(@"Load More Items...", @"");
        NSString* subtitle = [NSString stringWithFormat:
                              TTLocalizedString(@"Showing %d of %d Items", @""), [self.items count],
                              numberOfItemsInServerRecordset];
        
        return [[[TTMoreButtonTableField alloc] initWithText:title subtitle:subtitle] autorelease];
    } else {
        // Allow the super class to vend items directly from the list of items.
        return [super tableView:tableView objectForRowAtIndexPath:indexPath];
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isLoading)
        return 0;
    
    // if there is more data that can be loaded, make room for the "Load More Items" button.
    NSInteger maxIndex = [self.items count];
    return [self hasMoreToLoad] ? maxIndex + 1 : maxIndex;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTURLRequestDelegate

- (void)requestDidStartLoad:(TTURLRequest*)request
{
    [self dataSourceDidStartLoad];
}

- (void)requestDidFinishLoad:(TTURLRequest*)request
{
    TableItemsResponse *response = request.response;
    [self.items addObjectsFromArray:response.items];
    [response.items removeAllObjects];
    numberOfItemsInServerRecordset = response.numberOfItemsInServerRecordset;
    NSLog(@"Retrieved %d results from a recordset totaling %d records", [self.items count], numberOfItemsInServerRecordset);
    [self dataSourceDidFinishLoad];
}

- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error
{
    [self dataSourceDidFailLoadWithError:error];
}

- (void)requestDidCancelLoad:(TTURLRequest*)request
{
    [self dataSourceDidCancelLoad];
}


/////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTLoadable

- (NSDate*)loadedTime
{
    return lastLoadedTime;
}

- (BOOL)isLoading
{
    return isLoading;
}

- (BOOL)isLoadingMore
{
    return isLoadingMore;
}

- (BOOL)isLoaded
{
    return lastLoadedTime != nil;
}

- (void)invalidate:(BOOL)erase
{
    if (erase) {
        // remove any items from a previous query
        [self.items removeAllObjects];
    }
    
    // ensure that the data source is now marked as "outdated"
    [lastLoadedTime release];
    lastLoadedTime = [[NSDate distantPast] retain];
}

- (void)cancel
{
    NSLog(@"TableAsyncDataSource: asked to cancel, but this feature is not implemented.");
}

////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTDataSource

- (void)dataSourceDidStartLoad
{
    isLoading = YES;
    [super dataSourceDidStartLoad];
}

- (void)dataSourceDidFinishLoad
{
    isLoading = NO;
    isLoadingMore = NO;
    [lastLoadedTime release];
    lastLoadedTime = [[NSDate date] retain];
    [super dataSourceDidFinishLoad];
}

- (void)dataSourceDidFailLoadWithError:(NSError*)error
{
    TTLOG(@"TableAsyncDataSource dataSourceDidFailLoadWithError:%@", [error description]);
    isLoading = NO;
    isLoadingMore = NO;
    [super dataSourceDidFailLoadWithError:error];
}

- (void)dataSourceDidCancelLoad
{
    TTLOG(@"TableAsyncDataSource dataSourceDidCancelLoad");
    isLoading = NO;
    isLoadingMore = NO;
    [super dataSourceDidCancelLoad];
}

///////////////////////////////////////////////////////////////////////////////////
#pragma mark -

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ webService=%@\nnumSecondsSinceLastLoad=%.1f",
            [super description],
            self.webService,
            -1*[lastLoadedTime timeIntervalSinceNow]];
}

- (void) dealloc
{
    [webService release];
    [lastLoadedTime release];
    [super dealloc];
}


@end
