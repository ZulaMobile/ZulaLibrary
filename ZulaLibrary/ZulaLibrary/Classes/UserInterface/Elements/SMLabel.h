//
//  SMLabel.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMViewElement.h"
#import "UIColor+ZulaAdditions.h"

/**
 The vertical alignment of text within a label.
 @source http://sstoolk.it/
 */
typedef enum {
	/** Aligns the text vertically at the top in the label (the default). */
	SMLabelVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
	
	/** Aligns the text vertically in the center of the label. */
	SMLabelVerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
	
	/** Aligns the text vertically at the bottom in the label. */
	SMLabelVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} SMLabelVerticalTextAlignment;

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
@interface SMLabel : UILabel <SMViewElement>

/**
 The vertical text alignment of the receiver.
 
 The default is `SMLabelVerticalTextAlignmentMiddle` to match `UILabel`.
 */
@property (nonatomic, assign) SMLabelVerticalTextAlignment verticalTextAlignment;

/**
 The edge insets of the text.
 
 The default is `UIEdgeInsetsZero` so it behaves like `UILabel` by default.
 */
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

@end
