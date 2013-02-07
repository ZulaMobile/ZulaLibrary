//
//  SMAppDescription.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

/// notification keys
#define kNotificationAppDescriptionDidFetch @"kNotificationAppDescriptionDidFetch"
#define kNotificationAppDescriptionFail @"kNotificationAppDescriptionDidFetch"

@class SMAppearanceDescription, SMNavigationDescription;

@protocol SMAppDescriptionDataSource <NSObject>

- (void)fetchAppDescriptionWithCompletion:(void(^)(NSDictionary *response, NSError *error))completion;

@end

/**
 @class
 App description is the META data about the structure of the app.
 The data includes the installed components and their appearances.
 Please see wiki entry of REST Api - AppDescription service for details.
 */
@interface SMAppDescription : NSObject <SMAppDescriptionDataSource>

/**
 App title, a.k.a. the title of the app.
 */
@property (nonatomic, strong) NSString *appTitle;

/**
 The collection of component appearance data
 */
@property (nonatomic, strong) SMAppearanceDescription *appearance;

/**
 The navigation description data, includes navigation ui appearances and
 components in order
 */
@property (nonatomic, strong) SMNavigationDescription *navigation;

@property (nonatomic, unsafe_unretained) id<SMAppDescriptionDataSource> dataSource;

/**
 Singleton instance of the SMAppDescription.
 SMAppDescription holds the meta data (components, appearances) of the app
 */
+ (SMAppDescription *)sharedInstance;

/**
 Fetches the description via the data source and make it persistent for later use
 */
- (void)fetchAndSaveAppDescriptionWithCompletion:(void(^)(NSError *error))completion;

@end
