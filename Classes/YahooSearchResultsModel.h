//
//  YahooSearchResultsModel.h
//  Three20TableAsync
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "Three20/Three20.h"

@class URLModelResponse;

// NOTE that I factored out the HTTP response processing 
// into separate classes (YahooJSONResponse and YahooXMLResponse)
// simply because I'm demonstrating how to handle both data formats
// in a single demo app. In a real-world app, you would just be using
// one data format, in which case it would be simpler to just fold
// that functionality (JSON processing, for example) directly into
// the YahooSearchResultsModel class.
//
@interface YahooSearchResultsModel : TTURLRequestModel
{
    URLModelResponse *responseProcessor;
    NSString *searchTerms;
}

@property (nonatomic, readonly) NSArray *results;   // When your TTTableViewDataSource needs data to display, it should use this method to acquire the parsed SearchResult domain objects.
@property (nonatomic, readonly) NSUInteger totalResultsAvailableOnServer;
@property (nonatomic, retain) NSString *searchTerms;

@end
