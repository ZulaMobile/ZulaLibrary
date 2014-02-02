//
//  SMSwipeBackModule.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 31/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMComponentModule.h"


/**
 This module adds swiping gestures for UINavigationController
 
 These gestures are implemented for each component to achieve a consistent UX
 Standard behavior is to go back to the previous page if there is a navigation controller
 and the page is top on the stack
 */
@interface SMSwipeBackModule : NSObject <SMComponentModule>

@end
