//
//  AppDelegate.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 5/23/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "AppDelegate.h"
#import "YahooViewController.h"
#import "RemotePhotosViewController.h"

@implementation AppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    tabController = [[UITabBarController alloc] init];
    
    // TODO: rename YahooViewController to include "Table" in the name
    [tabController setViewControllers:
     [NSArray arrayWithObjects:
      [[[UINavigationController alloc] initWithRootViewController:[[[YahooViewController alloc] init] autorelease]] autorelease],
      [[[UINavigationController alloc] initWithRootViewController:[[[RemotePhotosViewController alloc] init] autorelease]] autorelease],
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
