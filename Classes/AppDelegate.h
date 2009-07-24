//
//  AppDelegate.h
//  Three20TableAsync
//
//  Created by Keith Lazuka on 5/23/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    UITabBarController *tabController;
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

