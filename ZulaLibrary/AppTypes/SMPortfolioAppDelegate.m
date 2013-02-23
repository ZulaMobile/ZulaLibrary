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
    
    // root view controller
    __block UIViewController *rootViewController = [[UIViewController alloc] init];
    
    // show the preloader screen
    UIViewController *preloader = [[SMPreloaderComponentViewController alloc] init];
    
    // fetch `app description`
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    [appDescription fetchAndSaveAppDescriptionWithCompletion:^(NSError *error) {
        if (error) {
            // show an error alert
            return;
        }
        
        // app description is fetched
        
        // create component instances
        SMContentPageViewController *contentComponent = [[SMContentPageViewController alloc] init];
        
        // create navigation
        
        // set up the root view controller and pages
        //[preloader.navigationController pushViewController:contentComponent animated:YES];
        
        [rootViewController dismissViewControllerAnimated:NO completion:^{
            [self.window addSubview:contentComponent.view];
            [rootViewController.view removeFromSuperview];
        }];
        
    }];
    
    // set root view controller as preloader controller temporarily
    //UIViewController *rootViewController = [[UIViewController alloc] init];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:rootViewController];
    [self.window makeKeyAndVisible];
    
    // show the modal preloader
    [rootViewController presentViewController:preloader animated:NO completion:nil];
    
    return YES;
}

@end
