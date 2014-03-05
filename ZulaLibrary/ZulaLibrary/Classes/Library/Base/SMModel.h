//
//  SMModel.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMModel : NSObject

/**
 The common initializer pattern for model objects.
 
 The model implementations are responsible for setting the properties of model instances. 
 Properties are readonly and can be only editable in the model implementation.
 
 @param Attributes The fetched/created data for the model in key-value dictionary
 @return Model instance
 */
- (id)initWithAttributes:(NSDictionary *)attributes;

/**
 Validator for the model
 Must be overridden by subclasses
 */
+ (BOOL)isValidResponse:(id)response;

/**
 Helper method
 Get the url string and return NSURL or nil
 */
- (NSURL*)urlFromAttribute:(NSString *)urlString;

@end
