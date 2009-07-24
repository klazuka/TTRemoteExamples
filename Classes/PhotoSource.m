//
//  PhotoSource.m
//  Three20RemotePhotos
//
//  Created by Keith Lazuka on 5/29/09.
//  
//

#import "PhotoSource.h"
#import "YahooSearchResultsModel.h"

@implementation PhotoSource

@synthesize title = albumTitle;

- (id)initWithModel:(YahooSearchResultsModel *)theModel
{
    if ((self = [super init])) {
        albumTitle = @"Photos";
        model = [theModel retain];
    }
    return self;
}

- (id<TTModel>)underlyingModel
{
    return model;
}

// -----------------------------------------------------------------------
#pragma mark Forwarding

// Forward unknown messages to the underlying TTModel object.
- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([model respondsToSelector:[invocation selector]])
        [invocation invokeWithTarget:model];
    else
        [super forwardInvocation:invocation];
}

- (BOOL)respondsToSelector:(SEL)selector
{
    if ([super respondsToSelector:selector])
        return YES;
    else
        return [model respondsToSelector:selector];
}

- (BOOL)conformsToProtocol:(Protocol *)protocol
{
    if ([super conformsToProtocol:protocol])
        return YES;
    else
        return [model conformsToProtocol:protocol];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (!signature)
        signature = [model methodSignatureForSelector:selector];
    return signature;
}

// -----------------------------------------------------------------------
#pragma mark TTPhotoSource

- (NSInteger)numberOfPhotos 
{
    // TODO We need to find a way to obtain the totalNumberOfPhotos
    //      available from the YahooSearchResultsModel.
    //return totalNumberOfPhotos;
    return 10;
}

- (NSInteger)maxPhotoIndex
{
    return [[model results] count] - 1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index 
{
    if (index < 0 || index > [self maxPhotoIndex])
        return nil;
    
    // TODO Wrap the SearchResult in a TTPhotoItem and get rid of 
    //      SearchResult's TTPhoto protocol conformance.
    id<TTPhoto> photo = [[model results] objectAtIndex:index];
    photo.index = index;
    photo.photoSource = self;
    return photo;
}

// -----------------------------------------------------------------------
#pragma mark -

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ delegates: %@", [super description], [self delegates]];
}

- (void)dealloc
{
    [model release];
    [albumTitle release];
    [super dealloc];
}

@end

