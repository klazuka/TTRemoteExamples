/*
 *  App.h
 *  TTRemoteExamples
 *
 *  Created by Keith Lazuka on 7/25/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
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
    SearchResponseFormatDefault = SearchResponseFormatJSON
} SearchResponseFormat;
extern SearchResponseFormat CurrentSearchResponseFormat;

id CreateSearchModelWithCurrentSettings(void);
id CreateSearchModel(SearchService service, SearchResponseFormat responseFormat);
