//
//  SearchResultsPhotoSource.m
//
//  Created by Keith Lazuka on 5/29/09.
//  
//

#import "SearchResultsPhotoSource.h"
#import "SearchResultsModel.h"
#import "SearchResult.h"

// NOTE: I have disabled compiler warnings on this source file (SearchResultsPhotoSource.m)
//       because the compiler keeps complaining that SearchResultsPhotoSource does not
//       conform to the TTPhotoSource protocol because the compiler isn't
//       smart enough to know about the Objective-C runtime forwarding.

@interface PhotoItem : NSObject <TTPhoto>
{
    NSString *caption;
    NSString *imageURL;
    NSString *thumbnailURL;
    id <TTPhotoSource> photoSource;
    CGSize size;
    NSInteger index;
}
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *thumbnailURL;
+ (id)itemWithImageURL:(NSString*)imageURL thumbImageURL:(NSString*)thumbImageURL caption:(NSString*)caption size:(CGSize)size;
@end

// -----------------------------------------------------------------------
#pragma mark -

@implementation SearchResultsPhotoSource

@synthesize title = albumTitle;

- (id)initWithModel:(id <SearchResultsModel>)theModel
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
    return [model totalResultsAvailableOnServer];
}

- (NSInteger)maxPhotoIndex
{
    return [[model results] count] - 1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index 
{
    if (index < 0 || index > [self maxPhotoIndex])
        return nil;
    
    // Construct an object (PhotoItem) that is suitable for Three20's
    // photo browsing system from the domain object (SearchResult)
    // at the specified index in the TTModel.
    SearchResult *result = [[model results] objectAtIndex:index];
    id<TTPhoto> photo = [PhotoItem itemWithImageURL:result.bigImageURL thumbImageURL:result.thumbnailURL caption:result.title size:result.bigImageSize];
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

// -----------------------------------------------------------------------
#pragma mark -

@implementation PhotoItem

@synthesize caption, photoSource, size, index; // properties declared in the TTPhoto protocol
@synthesize imageURL, thumbnailURL; // PhotoItem's own properties

+ (id)itemWithImageURL:(NSString*)theImageURL thumbImageURL:(NSString*)theThumbImageURL caption:(NSString*)theCaption size:(CGSize)theSize
{
    PhotoItem *item = [[[[self class] alloc] init] autorelease];
    item.caption = theCaption;
    item.imageURL = theImageURL;
    item.thumbnailURL = theThumbImageURL;
    item.size = theSize;
    return item;
}

// ----------------------------------------------------------
#pragma mark TTPhoto protocol

- (NSString*)URLForVersion:(TTPhotoVersion)version
{
    return (version == TTPhotoVersionThumbnail && thumbnailURL) 
    ? thumbnailURL
    : imageURL;
}

#pragma mark - 

- (void)dealloc
{
    [caption release];
    [imageURL release];
    [thumbnailURL release];
    [super dealloc];
}

@end

