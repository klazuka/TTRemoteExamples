//
//  YahooJSONResponse.h
//

#import "URLModelResponse.h"

/*
 *      YahooJSONResponse
 *      -----------------
 *
 *  Parses the HTTP response from a Yahoo Image Search query
 *  into a list of YahooSearchResult objects.
 *
 *  I use json-framework (http://code.google.com/p/json-framework/)
 *  to parse the JSON response and then store the parts
 *  in which we're interested to our domain object, "SearchResult".
 *
 */
@interface YahooJSONResponse : URLModelResponse
{
}

@end
