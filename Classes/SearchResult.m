//
//  SearchResult.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "SearchResult.h"


@implementation SearchResult

@synthesize title, imageURL, thumbnailURL;
@synthesize photoSource, size, index;

// ----------------------------------------------------------
#pragma mark TTPhoto protocol

- (NSString*)URLForVersion:(TTPhotoVersion)version
{
    return (version == TTPhotoVersionThumbnail && thumbnailURL) 
                ? thumbnailURL
                : imageURL;
}

// Alias the TTPhoto |caption| property to the |title| property.
- (NSString *)caption { return self.title; }
- (void)setCaption:(NSString *)caption { self.title = caption; }

// ----------------------------------------------------------
#pragma mark -

- (void)dealloc
{
    [title release];
    [imageURL release];
    [thumbnailURL release];
    [super dealloc];
}

@end
