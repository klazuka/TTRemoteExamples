/*
 *  App.h
 *  TTRemoteExamples
 *
 *  Created by Keith Lazuka on 7/25/09.
 *
 */

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
    SearchServiceDefault = SearchServiceFlickr
} SearchService;
extern SearchService CurrentSearchService;

typedef enum {
    SearchResponseFormatJSON,
    SearchResponseFormatXML,
    SearchResponseFormatDefault = SearchResponseFormatXML
} SearchResponseFormat;
extern SearchResponseFormat CurrentSearchResponseFormat;

id CreateSearchModelWithCurrentSettings(void);
id CreateSearchModel(SearchService service, SearchResponseFormat responseFormat);
