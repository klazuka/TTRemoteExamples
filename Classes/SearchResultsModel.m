//
//  SearchResultsModel.m
//
//  Created by Keith Lazuka on 7/25/09.
//

#import "SearchResultsModel.h"
#import "YahooSearchResultsModel.h"
#import "FlickrSearchResultsModel.h"

SearchService CurrentSearchService = SearchServiceDefault;
SearchResponseFormat CurrentSearchResponseFormat = SearchResponseFormatDefault;

id<SearchResultsModel> CreateSearchModel(SearchService service, SearchResponseFormat responseFormat)
{
    id<SearchResultsModel> model = nil;
    switch ( service ) {
        case SearchServiceYahoo:
            model = [[[YahooSearchResultsModel alloc] initWithResponseFormat:responseFormat] autorelease];
            break;
        case SearchServiceFlickr:
            model = [[[FlickrSearchResultsModel alloc] initWithResponseFormat:responseFormat] autorelease];
            break;
        default:
            [NSException raise:@"CurrentSearchService unknown" format:nil];
            break;
    }
    return model;
}

id<SearchResultsModel> CreateSearchModelWithCurrentSettings(void)
{
    return CreateSearchModel(CurrentSearchService, CurrentSearchResponseFormat);
}