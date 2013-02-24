//
//  SMDefaultAppDelegate.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMDefaultAppDelegate.h"
#import "SMAppDescription.h"
#import "SMPreloaderComponentViewController.h"
#import "SMContentPageViewController.h"
#import "SMComponentDescription.h"

@implementation SMDefaultAppDelegate
{
    /**
     The navigation component is on the heap to prevent memory issues
     */
    UITabBarController *navigationComponent;
}

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
        
        /* app description is fetched */
        
        // create navigation
        navigationComponent = [[UITabBarController alloc] init];
        
        // create component instances
        for (SMComponentDescription *componentDesc in appDescription.components) {
            if ([componentDesc.type isEqualToString:@"Content"]) {
                // create the component
                SMContentPageViewController *contentComponent = [[SMContentPageViewController alloc] initWithDescription:componentDesc];
                
                // add the component to the navigation
                [navigationComponent addChildViewController:contentComponent];
            }
        }
        
        // show the main window
        [rootViewController dismissViewControllerAnimated:NO completion:^{
            [self.window addSubview:navigationComponent.view];
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
