//
//  URLModelResponse.h
//  Three20TableAsync
//
//  Created by Keith Lazuka on 6/3/09.
//  
//

#import "Three20/Three20.h"

/*
 *      URLModelResponse
 *
 *  An abstract base class for HTTP response parsers
 *  that construct domain objects from the response.
 *
 */
@interface URLModelResponse : NSObject <TTURLResponse>
{
    NSMutableArray *objects;
}

@property (nonatomic, retain) NSMutableArray *objects; // Intended to be read-only for clients, read-write for sub-classes

+ (id)response;

@end
