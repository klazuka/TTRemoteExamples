//
//  YahooXMLResponse.h
//

#import "URLModelResponse.h"

/*
 *      YahooXMLResponse
 *      ----------------
 *
 *  Parses the HTTP response from a Yahoo Image Search query
 *  into a list of SearchResult objects.
 *
 *  I use KissXML (http://code.google.com/p/kissxml/)
 *  to construct a tree from the XML and to perform
 *  XPath queries in order to  store the parts
 *  in which we're interested to our domain object,
 *  "SearchResult".
 *
 */
@interface YahooXMLResponse : URLModelResponse
{
}

@end
