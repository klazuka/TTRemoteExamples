//
//  TableAsyncXMLDataSource.m
//

#import "TableAsyncXMLDataSource.h"

@implementation TableAsyncXMLDataSource

@synthesize results, currentResult, currentProperty;

/////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (void)load:(TTURLRequestCachePolicy)cachePolicy nextPage:(BOOL)nextPage
{
    // send the request to Yahoo's image search service
    // (note that we are requesting XML output)
    NSString *url = @"http://search.yahooapis.com/ImageSearchService/V1/imageSearch?appid=YahooDemo&query=beach&output=xml";
    TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
    request.cachePolicy = cachePolicy;
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
    request.httpMethod = @"GET";
    [request send];
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// TTURLRequestDelegate

- (void)requestDidFinishLoad:(TTURLRequest*)request
{
    TTURLDataResponse *response = request.response;
    
    // configure the parse to parse the XML data that we received
    // in the response from the server.
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:response.data];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    // the XML data itself was downloaded from the internet on a background thread,
    // but the XML will be *parsed* on the main thread... If your XML document is very large,
    // you will want to rewrite this class to parse on a background thread instead.
    [parser parse];
    
    NSError *parseError = [parser parserError];
    if (parseError) {
        NSLog(@"TableAsyncXMLDataSource - parse error %@", parseError);
        [self dataSourceDidFailLoadWithError:parseError];
    }
    
    [parser release];
}

- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error
{
    [self dataSourceDidFailLoadWithError:error];
}

- (void)requestDidCancelLoad:(TTURLRequest*)request
{
    [self dataSourceDidCancelLoad];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
// NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.results = [NSMutableArray array];
    [self dataSourceDidStartLoad];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    // append each result to the TTDataSource's list of items
    // so that they can be displayed by the table view.
    for(NSDictionary *result in self.results) {     
        [self.items addObject:[[[TTIconTableField alloc]
                                initWithText:[result objectForKey:@"Title"]
                                url:nil
                                image:[result objectForKey:@"Url"]
                                defaultImage:[UIImage imageNamed:@"DefaultAlbum.png"]] autorelease]];
    }
    
    [self dataSourceDidFinishLoad];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName)
        elementName = qName;
    
    if ([elementName isEqualToString:@"Result"]) {
        self.currentResult = [NSMutableDictionary dictionary];
        return;
    }
    
    // these are the attributes that we are interested in
    NSSet *searchProperties = [NSSet setWithObjects:@"Title", @"Url", nil];
    if ([searchProperties containsObject:elementName]) {
        self.currentProperty = [NSMutableString string];            
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (qName)
        elementName = qName;
    
    if ([elementName isEqualToString:@"Result"]) {
        [self.results addObject:self.currentResult];
        return;
    }
    
    // if we are not building up a property, then we are not interested in this end element.
    if (!self.currentProperty)
        return;
    
    [self.currentResult setObject:self.currentProperty forKey:elementName];
    
    self.currentProperty = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // If currentProperty is not nil, then we are interested in the 
    // content of the current element being parsed. So append it to the buffer.
    if (self.currentProperty)
        [self.currentProperty appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [self dataSourceDidFailLoadWithError:parseError];
}

- (void)dealloc
{
    [results release];
    [currentResult release];
    [currentProperty release];
    [super dealloc];
}

@end
