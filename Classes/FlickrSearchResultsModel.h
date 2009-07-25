//
//  FlickrSearchResultsModel.h
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "Three20/Three20.h"
#import "App.h"

@class URLModelResponse;

/*
 *      FlickrSearchResultsModel
 *      -----------------------
 *
 *  See the description of YahooSearchResultsModel.
 *
 */
@interface FlickrSearchResultsModel : TTURLRequestModel
{
    URLModelResponse *responseProcessor;
    NSString *searchTerms;
    NSUInteger page;
}

@property (nonatomic, readonly) NSArray *results;   // When your TTTableViewDataSource needs data to display, it should use this method to acquire the parsed SearchResult domain objects.
@property (nonatomic, readonly) NSUInteger totalResultsAvailableOnServer;
@property (nonatomic, retain) NSString *searchTerms;

- (id)initWithResponseFormat:(SearchResponseFormat)responseFormat;

@end
