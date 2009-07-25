/*
 *  SearchResultsModel.h
 *
 *  Created by Keith Lazuka on 7/25/09.
 *
 */

#import "Three20/Three20.h"

/*
 *  NOTE: this is where you can switch the web service between Flickr and Yahoo
 *        and between using the JSON and XML response processors.
 *        All you need to do is set SearchServiceDefault and 
 *        SearchResponseFormatDefault to the appropriate value.
 *
 */
typedef enum {
    SearchServiceYahoo,
    SearchServiceFlickr,
    SearchServiceDefault = SearchServiceYahoo
} SearchService;
extern SearchService CurrentSearchService;

typedef enum {
    SearchResponseFormatJSON,
    SearchResponseFormatXML,
    SearchResponseFormatDefault = SearchResponseFormatXML
} SearchResponseFormat;
extern SearchResponseFormat CurrentSearchResponseFormat;

#pragma mark -

/*
 *      SearchResultsModel
 *
 *  This protocol is intended for TTModels that represent a remote search service.
 *  
 */
@protocol SearchResultsModel <TTModel>

@property (nonatomic, readonly) NSArray *results;                           // A list of domain objects constructed by the model after parsing the web service's HTTP response. In this case, it is a list of SearchResult objects.
@property (nonatomic, readonly) NSUInteger totalResultsAvailableOnServer;   // The total number of results available on the server (but not necessarily downloaded) for the current model configuration's search query.
@property (nonatomic, retain) NSString *searchTerms;                        // The keywords that will be submitted to the web service in order to do the actual image search (e.g. "green apple")

- (id)initWithResponseFormat:(SearchResponseFormat)responseFormat;          // The designated initializer

@end

#pragma mark -

// Factory methods for instantiating a functioning SearchResultsModel.
id<SearchResultsModel> CreateSearchModelWithCurrentSettings(void);
id<SearchResultsModel> CreateSearchModel(SearchService service, SearchResponseFormat responseFormat);

