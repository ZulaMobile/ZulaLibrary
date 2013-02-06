//
//  SMComponentAppearance.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/6/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides values for the appearance of ui components (ui elements)
 
 Appearane values are fetched by the SMAppearanceDataSource (persistently if possible)
 and can be fethced using SMAppearance with default values.
 If the requested value cannot be found, SMAppearance returns its default value
 */
@interface SMComponentAppearance : NSObject
{
    // dictionary for keeping appearance values of model and compoentn
    NSDictionary *appearanceValues;
}

/**
 Unique identifier for the model class. See [SMModel identifier].
 */
@property NSString *modelIdentifier;

/**
 The name/identifier for the ui component. i.e. title
 */
@property NSString *componentName;

/**
 Returns a new appearance object for the model and component name.
 This method assumes that SMAppearance's fetch method is already fired and 
 necessary values are downloaded and stored persistently. Otherwise will only
 returns the default values
 
 @param ModelIdentifier Unique identifier for the model class. See [SMModel identifier].
 @param ComponentName The name/identifier for the ui component. i.e. title
 */
+ (SMComponentAppearance *)appearanceForModelIdentifier:(NSString *)modelIdentifier
                                          componentName:(NSString *)componenName
                                       appearanceValues:(NSDictionary *)appearanceValues;

/**
 Returns the string value for given key.
 If the value cannot be found, returns the pre-defined default value for the key.
 If the default value cannot be found, returns an empty string
 
 @param Key Identifier of the appearance value
 */
- (NSString *)stringForKey:(NSString *)key;

/**
 Returns the float value for given key.
 If the value cannot be found, attemps to returns the pre-defined default value for the key.
 It default value cannot be found, returns zero
 
 @param Key Identifier of the appearance value
 */
- (float)floatForKey:(NSString *)key;

@end
