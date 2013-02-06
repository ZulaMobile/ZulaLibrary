//
//  SMComponentAppearance.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/6/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMComponentAppearance.h"

@implementation SMComponentAppearance

@synthesize modelIdentifier = _modelIdentifier;
@synthesize componentName = _componentName;

+ (SMComponentAppearance *)appearanceForModelIdentifier:(NSString *)modelIdentifier componentName:(NSString *)componenName
{
    SMComponentAppearance *appearance = [[SMComponentAppearance alloc] init];
    [appearance setModelIdentifier:modelIdentifier];
    [appearance setComponentName:componenName];
    
    return appearance;
}

@end
