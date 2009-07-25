//
//  FlickrSearchResultsModel.h
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "Three20/Three20.h"
#import "SearchResultsModel.h"

@class URLModelResponse;

/*
 *      FlickrSearchResultsModel
 *      -----------------------
 *
 *  See the description of YahooSearchResultsModel.
 *
 */
@interface FlickrSearchResultsModel : TTURLRequestModel <SearchResultsModel>
{
    URLModelResponse *responseProcessor;
    NSString *searchTerms;
    NSUInteger page;
}

// The designated initializer is defined in the SearchResultsModel protocol.

@end
