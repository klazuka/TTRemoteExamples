//
//  SearchPhotosViewController.h
//

#import "Three20/Three20.h"

@class PhotoSource;

/*
 *      SearchPhotosViewController
 *      ------------------------
 *
 *  Displays a text field where the user enters their
 *  search terms and a search button to perform the search,
 *  which will in turn push in Three20's thumbnail browsing
 *  view controller to show the search results.
 *
 */
@interface SearchPhotosViewController : TTViewController
{
    UITextField *queryField;
    PhotoSource *photoSource;
}

@end

