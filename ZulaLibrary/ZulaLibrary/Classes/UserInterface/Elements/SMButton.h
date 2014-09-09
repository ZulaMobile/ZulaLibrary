//
//  SMButton.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
	SMButtonImagePositionLeft,
	SMButtonImagePositionRight
} SMButtonImagePosition;


/**
 A fancier button with gradients and borders
 
 It's planning to apply theming in future
 */
@interface SMButton : UIButton

@property (nonatomic, assign) SMButtonImagePosition imagePosition;

@end
