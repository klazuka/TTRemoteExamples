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
        numberOfItemsInServerRecordset = 0;
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

    NSAssert(self.webService, @"TableAsyncDataSouce cannot load:nextPage: until the webService property is set to a useful value.");
    
    // calculate the offset into the recordset to be retrieved
    NSInteger start = nextPage ? [self.items count] + 1 : 1;
    
    // send the asynchronous request to the web service
    [self.webService requestItemsFromIndex:start cachePolicy:cachePolicy delegate:self];
    
    isLoadingMore = start > 0;
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
        // TODO find a better way to clear the items in the WebService's responseProcessor
        [[self.webService.responseProcessor items] removeAllObjects];
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
