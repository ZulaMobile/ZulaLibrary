//
//  SMMainView.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/24/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"
#import "SMImageView.h"

/**
 A component'a root/parent view.
 App wide appearances will apply to this view
 * bg_color
 * bg_image
 * scroll_color
 */
@interface SMMainView : UIView <SMViewElement>

@property (nonatomic, strong) NSString *backgroundImageUrl;

@end
