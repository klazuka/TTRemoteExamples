//
//  YahooSearchResultsModel.h
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "Three20/Three20.h"
#import "SearchResultsModel.h"

@class URLModelResponse;

/*
 *      YahooSearchResultsModel
 *      -----------------------
 *
 *  Responsibilities: 
 *      - To send an HTTP query to the Yahoo Image Search web service.
 *      - To keep track of where it is in the recordset so that
 *        additional results for the same query can be retrieved.
 *      - To parse the HTTP response by dispatching on the response
 *        format (XML or JSON) to the appropriate URLModelResponse
 *        object.
 *      - To represent the results of the query in a manner that is
 *        not tied to how it will be displayed.
 *
 *  As Joe noted on the message board, the motivation behind the 
 *  the separation between the TTModel and TTTableViewDataSource
 *  is to allow complex apps to separate their data model from
 *  the way that the data will be displayed (e.g. in a UITableView).
 *  This demo app demonstrates how a single data model can be used
 *  in both a table view and in Three20's thumbnail/photo browsing
 *  system.
 *
 *  I factored out the HTTP response processing 
 *  into separate classes (YahooJSONResponse and YahooXMLResponse)
 *  simply because I'm demonstrating how to handle both data formats
 *  in a single demo app. In a real-world app, you would probably
 *  just use a single data format, in which case it would be simpler 
 *  to just fold that functionality (JSON processing, for example) 
 *  directly into the YahooSearchResultsModel class.
 *
 */
@interface YahooSearchResultsModel : TTURLRequestModel <SearchResultsModel>
{
    URLModelResponse *responseProcessor;
    NSString *searchTerms;
    NSUInteger recordOffset;
}

// The designated initializer is defined in the SearchResultsModel protocol.

@end
