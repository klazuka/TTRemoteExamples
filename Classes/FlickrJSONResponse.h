//
//  FlickrJSONResponse.h
//

#import "URLModelResponse.h"

/*
 *      FlickrJSONResponse
 *      -----------------
 *
 *  Parses the HTTP response from a Flickr image search query
 *  into a list of SearchResult objects.
 *
 *  I use json-framework (http://code.google.com/p/json-framework/)
 *  to parse the JSON response and then store the parts
 *  in which we're interested to our domain object, "SearchResult".
 *
 */
@interface FlickrJSONResponse : URLModelResponse
{
}

@end
