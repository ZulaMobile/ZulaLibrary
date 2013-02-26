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

#import "SMComponentDescription.h"
#import "SMComponentFactory.h"

#import "SMNavigation.h"
#import "SMTabbedNavigationViewController.h"
#import "SMNavigationFactory.h"
#import "SMNavigationDescription.h"

@implementation SMDefaultAppDelegate
{
    /**
     The navigation component is on the heap to prevent memory issues
     */
    UIViewController<SMNavigation> *navigationComponent;
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
        navigationComponent = [SMNavigationFactory navigationByType:appDescription.navigationDescription.type];
        [navigationComponent.apperanceManager applyAppearances:appDescription.appearance];
        
        // create component instances
        for (SMComponentDescription *componentDesc in appDescription.componentDescriptions) {
            UIViewController *component = [SMComponentFactory componentWithDescription:componentDesc];
            if (component) {
                [navigationComponent addChildComponent:component];
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
