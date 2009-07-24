//
//  SearchPhotosViewController.h
//

#import "Three20/Three20.h"

@class PhotoSource;

@interface SearchPhotosViewController : TTViewController
{
    UITextField *queryField;
    PhotoSource *photoSource;
}

@end

