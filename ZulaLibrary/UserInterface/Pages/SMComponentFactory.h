//
//  SMComponentFactory.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMBaseComponentViewController.h"
#import "SMComponentDescription.h"
#import "SMNavigationDescription.h"

@interface SMComponentFactory : NSObject

+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription;
+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription forNavigation:(SMNavigationDescription *)navigationDescription;

@end
