//
//  SearchResultsTableDataSource.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "SearchResultsTableDataSource.h"
#import "SearchResult.h"
#import "YahooSearchResultsModel.h"

@implementation SearchResultsTableDataSource

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    [super tableViewDidLoadModel:tableView];
    
    TTLOG(@"Removing all objects in the table view.");
    [self.items removeAllObjects];
    
    for (SearchResult *result in [(YahooSearchResultsModel*)self.model results])
        [self.items addObject:[TTTableImageItem itemWithText:result.title
                                                    imageURL:result.thumbnailURL
                                                defaultImage:[UIImage imageNamed:@"photo_placeholder.png"]
                                                         URL:nil]];
    
    TTLOG(@"Added %lu search result objects", (unsigned long)[self.items count]);
}

@end
