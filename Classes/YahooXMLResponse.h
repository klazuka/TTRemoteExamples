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
 *  I use Apple's streaming XML parser, although if I were
 *  to do it again, I would consider either:
 *
 *      KissXML  - http://code.google.com/p/kissxml/
 *      TouchXML - http://code.google.com/p/touchcode/wiki/TouchXML
 *  
 */
@interface YahooXMLResponse : URLModelResponse
{
    NSMutableArray *results;               // List of Yahoosearch image result objects
    NSMutableDictionary *currentResult;    // Current Yahoosearch image result
    NSMutableString *currentProperty;      // A temporary buffer of character data within an XML element that we are interested in.
}

@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, retain) NSMutableDictionary *currentResult;
@property (nonatomic, retain) NSMutableString *currentProperty;

@end
