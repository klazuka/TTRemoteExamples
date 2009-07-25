//
//  AppDelegate.m
//  Three20TableAsync
//
//  Created by Keith Lazuka on 5/23/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchTableViewController.h"
#import "SearchPhotosViewController.h"
#import "YahooSearchResultsModel.h"
#import "FlickrSearchResultsModel.h"
#import "App.h"
#import "Three20/Three20.h"

SearchService CurrentSearchService = SearchServiceDefault;
SearchResponseFormat CurrentSearchResponseFormat = SearchResponseFormatDefault;

id CreateSearchModel(SearchService service, SearchResponseFormat responseFormat)
{
    id model = nil;
    switch ( service ) {
        case SearchServiceYahoo:
            model = [[[YahooSearchResultsModel alloc] initWithResponseFormat:responseFormat] autorelease];
            break;
        case SearchServiceFlickr:
            model = [[[FlickrSearchResultsModel alloc] initWithResponseFormat:responseFormat] autorelease];
            break;
        default:
            [NSException raise:@"CurrentSearchService unknown" format:nil];
            break;
    }
    return model;
}

id CreateSearchModelWithCurrentSettings(void)
{
    return CreateSearchModel(CurrentSearchService, CurrentSearchResponseFormat);
}


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
