//
//  SMAppearanceDescription.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMAppearance;

/**
 Wrapper for appearances data for components. 
 This class stires appearance data for all components installed for the app.
 */
@interface SMAppearanceDescription : NSObject

/**
 Initializer of the data wrapper. Each member of the componentData is appearance values
 for each component. 
 
 @param ComponentData is the collection of component appearances.
 */
- (id)initWithComponents:(NSArray *)components;

/** @name Getter Methods */

/**
 Appearances data for the given component model and the slug.
 If the data is not found, returns nil
 */
- (SMAppearance *)appearanceForComponentSlug:(NSString *)slug;


//- (SMAppearance *)appearanceForComponentModel:(Class)model slug:(NSString *)slug;
//- (SMAppearance *)appearanceForComponent:(UIViewController *)component;

@end
