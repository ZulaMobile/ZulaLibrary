//
//  SMHomePageLinks.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"

@interface SMHomePageLinks : UIControl <SMViewElement>

/**
 The padding of each link
 */
@property (nonatomic) NSInteger padding;

/**
 Selected component index
 */
@property (nonatomic) NSInteger selectedIndex;

@end
