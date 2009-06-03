//
//  TableAsyncXMLDataSource.h
//

#import <Foundation/Foundation.h>
#import "TableAsyncDataSource.h"

@interface TableAsyncXMLDataSource : TableAsyncDataSource
{
    NSMutableArray *results;               // list of Yahoosearch image result objects
    NSMutableDictionary *currentResult;    // current Yahoosearch image result
    NSMutableString *currentProperty;      // a temporary buffer of character data within an XML element that we are interested in.
}

@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, retain) NSMutableDictionary *currentResult;
@property (nonatomic, retain) NSMutableString *currentProperty;

@end
