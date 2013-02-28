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

#import "SMLogManager.h"

#import "SMComponentDescription.h"
#import "SMComponentFactory.h"

#import "SMTabbedNavigationViewController.h"
#import "SMNavigationFactory.h"
#import "SMNavigationDescription.h"
#import "SMNavigation.h"

@implementation SMDefaultAppDelegate
@synthesize navigationComponent = _navigationComponent;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // start logging
    SMLogManager *logManager = [[SMLogManager alloc] init];
    [logManager start];
    
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
        self.navigationComponent = [SMNavigationFactory navigationByType:appDescription.navigationDescription.type];
        [self.navigationComponent.apperanceManager applyAppearances:appDescription.appearance];
        
        // create component instances
        for (SMComponentDescription *componentDesc in appDescription.componentDescriptions) {
            UIViewController *component = [SMComponentFactory componentWithDescription:componentDesc forNavigation:appDescription.navigationDescription];
            if (component) {
                [self.navigationComponent addChildComponent:component];
            }
        }
        
        // show the main window
        [rootViewController dismissViewControllerAnimated:NO completion:^{
            [self.window addSubview:self.navigationComponent.view];
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
