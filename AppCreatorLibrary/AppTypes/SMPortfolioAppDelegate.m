//
//  SMPortfolioAppDelegate.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPortfolioAppDelegate.h"
#import "SMAppDescription.h"
#import "SMPreloaderComponentViewController.h"
#import "SMContentPageViewController.h"

@implementation SMPortfolioAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // show the preloader screen
    SMPreloaderComponentViewController *preloader = [[SMPreloaderComponentViewController alloc] init];
    
    // fetch `app description`
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    [appDescription fetchAndSaveAppDescriptionWithCompletion:^(NSError *error) {
        if (error) {
            // show an error alert
            return;
        }
        
        // app description is fetched
        // create component instances
        
        
        // create navigation
        
        // set up the root view controller and pages
        
        
        //SMContentPageViewController *ctrl = [[SMContentPageViewController alloc] initWithNibName:@"SMContentPageViewController" bundle:nil];
        //[self.window setRootViewController:ctrl];
        
    }];
    
    // set root view controller as preloader controller temporarily
    //UIViewController *rootViewController = [[UIViewController alloc] init];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:preloader];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
