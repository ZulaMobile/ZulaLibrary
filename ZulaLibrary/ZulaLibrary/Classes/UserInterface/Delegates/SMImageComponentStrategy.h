//
//  SMImageComponentDelegate.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMComponentDelegate.h"
#import "SMImageView.h"

/**
 Delegate that adds opening full screen image when tapping on a SMImage
 */
@interface SMImageComponentStrategy : NSObject <SMComponentStrategy, SMImageViewDelegate>

@end
