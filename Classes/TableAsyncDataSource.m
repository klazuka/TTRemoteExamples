//
//  TableAsyncDataSource.m
//

#import "TableAsyncDataSource.h"
#import "TableItemsResponse.h"
#import "GTMNSDictionary+URLArguments.h"

@implementation TableAsyncDataSource

@synthesize url;
@synthesize urlQueryParameters;
@synthesize responseProcessor;
@synthesize isActive;

// TODO store lastLoadedTime under a dictionary where the keys are the fullUrl

- (id)init
{
    if ((self = [super init])) {
        isActive = YES;
    }
    return self;
}

/*
- (void)loadPhotosFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex cachePolicy:(TTURLRequestCachePolicy)cachePolicy
{
    
}
 */

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewDataSource

- (void)load:(TTURLRequestCachePolicy)cachePolicy nextPage:(BOOL)nextPage
{
    NSLog(@"load:nextPage:%@ sent to %@", nextPage ? @"YES" : @"NO", self);
    if (!isActive) {
        NSLog(@"TableAsyncDataSource is not active so I will ignore this request to load:nextPage:");
        return;
    }
    
    /*
     *    Maybe instead of doing this, I should follow the loadPhotosFromIndex:toIndex:cachePolicy: model
     *    In order to support automatic "load more results"?
     *
    // calculate the offset into the recordset to be retrieved
    int start = nextPage ? [self.items count] + 1 : 1;
     */
    
    // send the request to the web service
    NSString *fullUrl = [NSString stringWithFormat:
                     @"%@?%@",
                     self.url,
                     [self.urlQueryParameters gtm_httpArgumentsString]];
    
    TTURLRequest *request = [TTURLRequest requestWithURL:fullUrl delegate:self];
    request.cachePolicy = cachePolicy;
    request.response = self.responseProcessor;
    request.httpMethod = @"GET";
    [request send];
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
        [[self.responseProcessor items] removeAllObjects];
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
    return [NSString stringWithFormat:@"%@ url=%@\nurlQueryParameters=%@\nresponseProcessor=%@\nnumSecondsSinceLastLoad=%.1f",
            [super description],
            self.url,
            self.urlQueryParameters,
            self.responseProcessor,
            -1*[lastLoadedTime timeIntervalSinceNow]];
}

- (void) dealloc
{
    [url release];
    [urlQueryParameters release];
    [responseProcessor release];
    [lastLoadedTime release];
    [super dealloc];
}


@end
