//
//  SMDefaultAppDelegate.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMDefaultAppDelegate.h"
#import "SMNavigationApperanceManager.h"
#import "SMBaseComponentViewController.h"

#import "SMAppDescription.h"
#import "SMAppDescriptionDummyDataSource.h"
#import "SMAppDescriptionRestApiDataSource.h"

#import "SMLogManager.h"

#import "SMComponentDescription.h"
#import "SMComponentFactory.h"

#import "SMTabbedNavigationViewController.h"
#import "SMNavigationFactory.h"
#import "SMNavigationDescription.h"
#import "SMNavigation.h"

@interface SMDefaultAppDelegate()
- (void)launchApp;
- (void)showErrorScreen;
- (void)showErrorScreenWithError:(NSError *)error;
@end

@implementation SMDefaultAppDelegate
{
    __block UIViewController *rootViewController;
    __block SMPreloaderComponentViewController *preloader;
}
@synthesize navigationComponent = _navigationComponent;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // common operations
    [self prepareApp];
    
    // root view controller
    rootViewController = [[UIViewController alloc] init];
    
    // init the preloader screen
    preloader = [[SMPreloaderComponentViewController alloc] init];
    [preloader setDelegate:self];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:rootViewController];
    [self.window makeKeyAndVisible];
    
    // show the modal preloader
    [rootViewController presentViewController:preloader animated:NO completion:^{
        // launch the app
        [self launchApp];
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showErrorScreen)
                                                 name:kMalformedAppNotification
                                               object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)refreshApp
{
    [self launchApp];
}

- (void)prepareApp
{
    // start logging
    SMLogManager *logManager = [[SMLogManager alloc] init];
    [logManager start];
    
}

#pragma mark - private methods

- (void)launchApp
{
    // fetch `app description`
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    
    //SMAppDescriptionDummyDataSource *dummyDataSource = [[SMAppDescriptionDummyDataSource alloc] init];
    //[appDescription setDataSource:dummyDataSource];
    
    SMAppDescriptionRestApiDataSource *restApiDataSource = [[SMAppDescriptionRestApiDataSource alloc] init];
    [appDescription setDataSource:restApiDataSource];
    
    [appDescription fetchAndSaveAppDescriptionWithCompletion:^(NSError *error) {
        if (error) {
            DDLogError(@"app description could not be fetched: %@", error);
            // show an error alert
            //[preloader setErrorMessage:[NSString stringWithFormat:NSLocalizedString(@"%@ Please tap anywhere to try again", nil), error.localizedDescription]];
            //[preloader onAppFail];
            [self showErrorScreenWithError:error];
            return;
        }
        
        /* app description is fetched */
        
        // create navigation
        self.navigationComponent = [SMNavigationFactory navigationByType:appDescription.navigationDescription.type];
        [self.navigationComponent.apperanceManager applyAppearances:appDescription.appearance];
        
        // add component descriptions to the navigation
        for (SMComponentDescription *componentDesc in appDescription.componentDescriptions) {
            [self.navigationComponent addChildComponentDescription:componentDesc];
        }
        
        [self.window setRootViewController:self.navigationComponent];

        rootViewController = nil;
        preloader = nil;
    }];
}

- (void)showErrorScreen
{
    [self showErrorScreenWithError:nil];
}

- (void)showErrorScreenWithError:(NSError *)error
{
    // init the preloader screen again
    if (!preloader) {
        preloader = [[SMPreloaderComponentViewController alloc] init];
        [preloader setDelegate:self];
    }
    
    if (error) {
        [preloader setErrorMessage:[NSString stringWithFormat:NSLocalizedString(@"%@ Please tap anywhere to try again", nil), error.localizedDescription]];
    } else {
        [preloader setErrorMessage:[NSString stringWithFormat:NSLocalizedString(@"Malformed Application. Please tap anywhere to try again", nil)]];
    }
    
    // show the modal preloader
    [self.window.rootViewController presentViewController:preloader animated:NO completion:^{
        [preloader onAppFail];
    }];
}

#pragma mark - preloader delegate

- (void)preloaderOnErrButton
{
    // relaunch app
    [self launchApp];
}

@end
