//
//  YahooXMLResponse.h
//

#import "URLModelResponse.h"

/*
 *      YahooXMLResponse
 *
 *  Parses the HTTP response from a Yahoo Image Search query
 *  into a list of SearchResult objects.
 *
 *  I use KissXML (http://code.google.com/p/kissxml/)
 *  to construct a tree from the XML and to perform
 *  XPath queries.
 *
 */
@interface YahooXMLResponse : URLModelResponse
{
}

@end
