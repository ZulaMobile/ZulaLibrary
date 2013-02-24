//
//  SMTextView.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SSTextView.h"
#import "SMViewElement.h"
#import "UIColor+SSToolkitAdditions.h"

/**
 Standard uitextview element
 
 Appearance options:
 * alignment: text alignment, accepted values are: left, right, center, justified.
 * bg_color: hex code for rgb color (i.e. rrggbb).
 * color: hex code for text color
 * font-size: number
 * font: the font family (string)
 */
@interface SMTextView : SSTextView <SMViewElement>

@end
