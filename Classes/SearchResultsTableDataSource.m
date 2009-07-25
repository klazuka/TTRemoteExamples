//
//  SearchResultsTableDataSource.m
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "SearchResultsTableDataSource.h"
#import "SearchResult.h"

@implementation SearchResultsTableDataSource

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    [super tableViewDidLoadModel:tableView];
    
    TTLOG(@"Removing all objects in the table view.");
    [self.items removeAllObjects];
    
    // Construct an object that is suitable for the table view system
    // from each SearchResult domain object that we retrieve from the TTModel.
    for (SearchResult *result in [self.model results])
        [self.items addObject:[TTTableImageItem itemWithText:result.title
                                                    imageURL:result.thumbnailURL
                                                defaultImage:[UIImage imageNamed:@"photo_placeholder.png"]
                                                         URL:nil]];
    
    TTLOG(@"Added %lu search result objects", (unsigned long)[self.items count]);
}

@end
