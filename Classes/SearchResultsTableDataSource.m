//
//  SearchResultsTableDataSource.m
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "SearchResultsTableDataSource.h"
#import "SearchResult.h"
#import "SearchResultsModel.h"

@implementation SearchResultsTableDataSource

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    [super tableViewDidLoadModel:tableView];
    
    TTLOG(@"Removing all objects in the table view.");
    [self.items removeAllObjects];
    
    // Construct an object that is suitable for the table view system
    // from each SearchResult domain object that we retrieve from the TTModel.
    for (SearchResult *result in [(id<SearchResultsModel>)self.model results]) {
        TTTableImageItem* tii = [TTTableImageItem itemWithText:result.title
                                                      imageURL:result.thumbnailURL
                                                  defaultImage:[UIImage imageNamed:@"photo_placeholder.png"]
                                                           URL:nil];

        // There is a bug in Three20's table cell image logic w.r.t.
        // Three20's image cache. By applying this TTImageStyle, we can
        // override the layout logic to force the image to always be a fixed size.
        // (thanks RoBak42 for the workaround!)
        tii.imageStyle = [TTImageStyle styleWithImage:nil
                                         defaultImage:[UIImage imageNamed:@"photo_placeholder.png"]
                                          contentMode:UIViewContentModeScaleAspectFill
                                                 size:CGSizeMake(75.f, 75.f)
                                                 next:nil];
        [self.items addObject:tii];
    }
    
    TTLOG(@"Added %lu search result objects", (unsigned long)[self.items count]);
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewDataSource protocol

- (UIImage*)imageForEmpty
{
	return [UIImage imageNamed:@"Three20.bundle/images/empty.png"];
}

- (UIImage*)imageForError:(NSError*)error
{
    return [UIImage imageNamed:@"Three20.bundle/images/error.png"];
}

@end
