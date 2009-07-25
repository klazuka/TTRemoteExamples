//
//  AppDelegate.m
//
//  Created by Keith Lazuka on 5/23/09.
//

#import "AppDelegate.h"
#import "SearchTableViewController.h"
#import "SearchPhotosViewController.h"
#import "Three20/Three20.h"

@implementation AppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // Allow HTTP response size to be unlimited.
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0];
    
    // Configure the in-memory image cache to keep approximately
    // 10 images in memory, assuming that each picture's dimensions
    // are 320x480. Note that your images can have whatever dimensions
    // you want, I am just setting this to a reasonable value
    // since the default is unlimited.
    [[TTURLCache sharedCache] setMaxPixelCount:10*320*480];
        
    tabController = [[UITabBarController alloc] init];
    
    [tabController setViewControllers:
     [NSArray arrayWithObjects:
      [[[UINavigationController alloc] initWithRootViewController:[[[SearchTableViewController alloc] init] autorelease]] autorelease],
      [[[UINavigationController alloc] initWithRootViewController:[[[SearchPhotosViewController alloc] init] autorelease]] autorelease],
      nil]];
    
    [window addSubview:[tabController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc
{
    [tabController release];
    [window release];
    [super dealloc];
}


@end
