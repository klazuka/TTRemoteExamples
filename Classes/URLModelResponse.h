//
//  URLModelResponse.h
//
//  Created by Keith Lazuka on 6/3/09.
//  
//

#import "Three20/Three20.h"

/*
 *      URLModelResponse
 *      ----------------
 *
 *  An abstract base class for HTTP response parsers
 *  that construct domain objects from the response.
 *
 *  Subclasses are responsible for setting the 
 *  |totalObjectsAvailableOnServer| property from
 *  the HTTP response. This enables features like
 *  the photo browsing systems automatic
 *  "Load More Photos" button.
 *
 */
@interface URLModelResponse : NSObject <TTURLResponse>
{
    NSMutableArray *objects;
    NSUInteger totalObjectsAvailableOnServer;
}

@property (nonatomic, retain) NSMutableArray *objects; // Intended to be read-only for clients, read-write for sub-classes
@property (nonatomic, readonly) NSUInteger totalObjectsAvailableOnServer;

+ (id)response;
- (NSString *)format;

@end
