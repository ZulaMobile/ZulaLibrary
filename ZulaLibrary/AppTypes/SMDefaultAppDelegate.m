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
#import "SMAppDescriptionRestApiDataSource.h"

#import "SMLogManager.h"

#import "SMComponentDescription.h"
#import "SMComponentFactory.h"

#import "SMTabbedNavigationViewController.h"
#import "SMNavigationFactory.h"
#import "SMNavigationDescription.h"
#import "SMNavigation.h"

#import "SMApiClient.h"


#define kPushNotificationDidReceive @"kPushNotificationDidReceive"

@interface SMDefaultAppDelegate()
- (void)launchAppWithCompletion:(void(^)(NSError *))completion;
- (void)showErrorScreen;
- (void)showErrorScreenWithError:(NSError *)error;
@end

@implementation SMDefaultAppDelegate
{
    __block UIViewController *rootViewController;
    __block SMPreloaderComponentViewController *preloader;
}
@synthesize navigationComponent = _navigationComponent;
@synthesize appDataSource = _appDataSource;

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
        [self launchAppWithCompletion:nil];
    }];
    
    application.applicationIconBadgeNumber = 0;
    
    // push notifications
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    UILocalNotification *remoteNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotif) {
        [self application:application didReceiveRemoteNotification:nil];
    }
    
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
    [self launchAppWithCompletion:nil];
}

- (void)refreshAppWithCompletion:(void (^)(NSError *))completion
{
    [self launchAppWithCompletion:completion];
}

- (void)prepareApp
{
    // start logging
    SMLogManager *logManager = [[SMLogManager alloc] init];
    [logManager start];
    
}

#pragma mark - getter setters

- (id<SMAppDescriptionDataSource>)appDataSource
{
    if (!_appDataSource) {
        _appDataSource = [[SMAppDescriptionRestApiDataSource alloc] init];
    }
    return _appDataSource;
}

- (void)setAppDataSource:(id<SMAppDescriptionDataSource>)appDataSource
{
    _appDataSource = appDataSource;
}

#pragma mark - private methods

- (void)launchAppWithCompletion:(void (^)(NSError *))completion
{
    // fetch `app description`
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    
    [appDescription setDataSource:self.appDataSource];
    
    [appDescription fetchAndSaveAppDescriptionWithCompletion:^(NSError *error) {
        if (error) {
            DDLogError(@"app description could not be fetched: %@", error);
            // show an error alert
            //[preloader setErrorMessage:[NSString stringWithFormat:NSLocalizedString(@"%@ Please tap anywhere to try again", nil), error.localizedDescription]];
            //[preloader onAppFail];
            [preloader onAppFail];
            //[self showErrorScreenWithError:error];
            if (completion) completion(error);
            return;
        }
        
        /* app description is fetched */
        
        // create navigation
        self.navigationComponent = [SMNavigationFactory navigationByType:appDescription.navigationDescription.type];
        [self.navigationComponent.apperanceManager applyAppearances:appDescription.appearance];
        
        // add component descriptions to the navigation
        NSInteger index = 0;
        for (SMComponentDescription *componentDesc in appDescription.componentDescriptions) {
            componentDesc.index = index;
            [self.navigationComponent addChildComponentDescription:componentDesc];
            index++;
        }
        
        [self.window setRootViewController:self.navigationComponent];
        
        if (completion) completion(nil);
        rootViewController = nil;
        preloader = nil;
    }];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
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
    [self launchAppWithCompletion:nil];
}

#pragma mark - push notifications

- (void)sendTokenToServer:(NSString *)token
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:token, @"token", nil];
    
    [[SMApiClient sharedClient] postPath:@"/devicetokens" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"device token is saved");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"device token cannot be saved");
    }];
}

// Delegation methods
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    
    const unsigned *tokenBytes = [devToken bytes];
    NSString *tokenStr = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tokenStr forKey:@"token"];
    [defaults synchronize];
    
    [self performSelectorInBackground:@selector(sendTokenToServer:) withObject:tokenStr];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    //[[[UIAlertView alloc] initWithTitle:@"Device token failed" message:[NSString stringWithFormat:@"%@", [err description]] delegate:Nil cancelButtonTitle:@"Token registration failed?" otherButtonTitles:nil, nil] show];
}

- (void)application:(UIApplication *)app didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // push notification increased the badge number outside the app
    // when user opens the app, we should clear the badge
    app.applicationIconBadgeNumber = 0;
    
    // alert observerts to do whatever they have to do with notifications
    [[NSNotificationCenter defaultCenter] postNotificationName:kPushNotificationDidReceive object:nil];
}


@end
