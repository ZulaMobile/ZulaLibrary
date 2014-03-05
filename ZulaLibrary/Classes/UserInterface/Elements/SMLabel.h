//
//  SMLabel.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SSLabel.h"
#import "SMViewElement.h"
#import "UIColor+ZulaAdditions.h"

/**
 Standard uilabel element
 
 Appearance options:
    * alignment: text alignment, accepted values are: left, right, center, top, bottom. Default is left
    * bg_color: hex code for rgb color (i.e. rrggbb).
    * color: hex code for text color
    * font-size: number
    * font: the font family (string)
 
 @see [[Label Element]] wiki entry
 */
@interface SMLabel : SSLabel <SMViewElement>

@end
