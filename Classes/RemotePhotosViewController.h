//
//  RemotePhotosViewController.h
//

#import "Three20/Three20.h"

@class PhotoSource;

@interface RemotePhotosViewController : TTViewController
{
    UITextField *queryField;
    PhotoSource *photoSource;
}

@end

