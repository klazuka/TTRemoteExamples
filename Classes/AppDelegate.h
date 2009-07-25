//
//  AppDelegate.h
//
//  Created by Keith Lazuka on 5/23/09.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    UITabBarController *tabController;
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

