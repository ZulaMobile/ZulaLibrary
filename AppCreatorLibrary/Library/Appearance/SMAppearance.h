//
//  SMAppearance.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/6/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMComponentAppearance.h"

@protocol SMAppearanceDataSource;

/**
 Loads appearance values via data source
 */
@interface SMAppearance : NSObject

/**
 The data source responsible from data fetching and persistance
 */
@property (nonatomic, unsafe_unretained) id<SMAppearanceDataSource> dataSource;

+ (SMAppearance *)sharedInstance;

- (void)fetchAppearanceWithBlock:(void(^)(NSError *error))block;
- (SMComponentAppearance *)componentAppearanceForModelIdentifier:(NSString *)modelIdentifier componentName:(NSString *)componentName;

@end


@protocol SMAppearanceDataSource <NSObject>

/**
 Downloads values from data source (i.e. server)
 */
- (void)appearance:(SMAppearance *)appearance fetchAppearanceWithBlock:(void(^)(NSError *error))block;

/**
 Returns the component appearance class instance which gives relevant appearance values for the model.
 
 @param ModelIdentifier Unique identifier for the model class. See [SMModel identifier].
 @param ComponentName The name/identifier for the ui component. i.e. title
 */
- (SMComponentAppearance *)componentAppearanceForModelIdentifier:(NSString *)modelIdentifier
                                                   componentName:(NSString *)componentName;

@end


