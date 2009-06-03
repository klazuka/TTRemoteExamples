//
//  TableAsyncDataSource.m
//

#import "TableAsyncDataSource.h"

@implementation TableAsyncDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLoadable

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

//////////////////////////////////////////////////////////////////////////////////////////////////
// TTDataSource

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

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void) dealloc
{
    [lastLoadedTime release];
    [super dealloc];
}


@end
