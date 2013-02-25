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

@class SMComponentDescription, SMNavigationDescription;

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
 App title, a.k.a. the title of the app (set by user)
 */
@property (nonatomic, strong) NSString *appTitle;

/**
 App wide appearance dictionary.
 @see [[App Wide Appearances]] wiki entry for available options
 */
@property (nonatomic, strong) NSDictionary *appearance;

/**
 The collection of SMComponentDescription object
 */
@property (nonatomic, strong) NSArray *componentDescriptions;

/**
 The navigation description data, includes navigation ui appearances and
 components in order
 */
@property (nonatomic, strong) SMNavigationDescription *navigationDescription;

@property (nonatomic, unsafe_unretained) id<SMAppDescriptionDataSource> dataSource;

/**
 Singleton instance of the SMAppDescription.
 SMAppDescription holds the meta data (components, appearances) of the app
 */
+ (SMAppDescription *)sharedInstance;

/**
 Retrieves component description instance by its slug
 nil if not found
 */
- (SMComponentDescription *)componentDescriptionWithSlug:(NSString *)slug;

/**
 Fetches the description via the data source and make it persistent for later use
 */
- (void)fetchAndSaveAppDescriptionWithCompletion:(void(^)(NSError *error))completion;

@end
