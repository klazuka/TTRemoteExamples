//
//  URLModelResponse.m
//
//  Created by Keith Lazuka on 6/3/09.
//  
//

#import "URLModelResponse.h"

@implementation URLModelResponse

@synthesize objects, totalObjectsAvailableOnServer;

+ (id)response
{
    return [[[[self class] alloc] init] autorelease];
}

- (id)init
{
    if ((self = [super init])) {
        objects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [objects release];
    [super dealloc];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTURLResponse

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
    NSAssert(NO, @"URLModelResponse is an abstract class. Sub-classes must implement request:processResponse:data:");
    return nil;
}

- (NSString *)format
{
    NSAssert(NO, @"URLModelResponse is an abstract class. Sub-classes must implement format");
    return nil;
}

@end