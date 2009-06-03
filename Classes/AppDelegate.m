//
//  AppDelegate.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 5/23/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "AppDelegate.h"
#import "TableAsyncViewController.h"

@implementation AppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    UIViewController *controller = [[[TableAsyncViewController alloc] init] autorelease];
    
    navController = [[UINavigationController alloc] 
                     initWithRootViewController:controller];
    
    [window addSubview:[navController view]];
    
    [window makeKeyAndVisible];
}


- (void)dealloc
{
    [navController release];
    [window release];
    [super dealloc];
}


@end
