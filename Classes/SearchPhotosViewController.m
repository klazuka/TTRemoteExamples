//
//  SearchPhotosViewController.m
//

#import "SearchPhotosViewController.h"
#import "SearchResultsPhotoSource.h"
#import "YahooSearchResultsModel.h"

@implementation SearchPhotosViewController

- (id)init
{
    if ((self = [super init])) {
        self.title = @"Photo example";
        photoSource = [[SearchResultsPhotoSource alloc] initWithModel:CreateSearchModelWithCurrentSettings()];
    }
    return self;
}

- (void)doSearch
{
    NSLog(@"Searching for %@", queryField.text);
    
    // Configure the photo source with the user's search terms
    // and load the new data.
    [photoSource setSearchTerms:[queryField text]];
    [queryField resignFirstResponder];
    [photoSource load:TTURLRequestCachePolicyDefault more:NO];
    
    // Display the updated photoSource.
    TTThumbsViewController *thumbs = [[TTThumbsViewController alloc] init];
    [thumbs setPhotoSource:photoSource];
    // Ugly hack: the TTModel system does not expect that your TTPhotoSource implementation
    // is actually forwarding to another object in order to conform to the TTModel aspect
    // of the TTPhotoSource protocol. So I have to ensure that the TTModelViewController's
    // notion of what its model is matches the object that it will receive 
    // via the TTModelDelegate messages.
    thumbs.model = [photoSource underlyingModel]; 
    [self.navigationController pushViewController:thumbs animated:YES];
    [thumbs release];
}

- (void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:TTApplicationFrame()] autorelease];
    self.view.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.f];
    
    // Search query field.
    queryField = [[UITextField alloc] initWithFrame:CGRectMake(30.f, 30.f, 260.f, 30.f)];
    queryField.placeholder = @"Image Search";
    queryField.autocorrectionType = NO;
    queryField.autocapitalizationType = NO;
    queryField.clearsOnBeginEditing = YES;
    queryField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:queryField];
        
    // Search button.
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [searchButton setFrame:CGRectMake(190.f, 140.f, 100.f, 44.f)];
    [searchButton addTarget:self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
}

- (void)dealloc
{
    [queryField release];
    [photoSource release];
    [super dealloc];
}


@end
