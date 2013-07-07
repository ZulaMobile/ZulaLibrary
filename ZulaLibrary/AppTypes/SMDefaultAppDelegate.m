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
            [preloader setErrorMessage:[NSString stringWithFormat:NSLocalizedString(@"%@ Please tap anywhere to try again", nil), error.localizedDescription]];
            [preloader onAppFail];
            return;
        }
        
        /* app description is fetched */
        
        // create navigation
        self.navigationComponent = [SMNavigationFactory navigationByType:appDescription.navigationDescription.type];
        [self.navigationComponent.apperanceManager applyAppearances:appDescription.appearance];
        
        //DDLogInfo(@"component descs: %@", appDescription.componentDescriptions);
        
        // add component descriptions to the navigation
        for (SMComponentDescription *componentDesc in appDescription.componentDescriptions) {
            [self.navigationComponent addChildComponentDescription:componentDesc];
        }
        
        [self.window setRootViewController:self.navigationComponent];
        
        rootViewController = nil;
        preloader = nil;
    }];
}

#pragma mark - preloader delegate

- (void)preloaderOnErrButton
{
    // relaunch app
    [self launchApp];
}

@end
