//
//  SMWebView.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/24/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"

/**
 Standard web view element
 
 Appearance options:
 * bg_color: hex code for rgb color (i.e. rrggbb).
 * text_shadow: #FF0000;
 
 */
@interface SMWebView : UIWebView <SMViewElement>

@end
