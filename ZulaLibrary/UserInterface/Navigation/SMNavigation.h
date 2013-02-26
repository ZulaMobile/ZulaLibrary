//
//  SMNavigation.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMNavigation <NSObject>

@property(nonatomic,copy) NSArray *components;

- (void)addChildComponent:(UIViewController *)component;

@end
