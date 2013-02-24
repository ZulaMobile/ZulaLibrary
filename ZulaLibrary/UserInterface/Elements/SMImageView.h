//
//  SMImageView.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"

/**
 Standard image view
 
 Appearance options:
     * alignment: the content mode [center, left, right, aspect_fill, aspect_fit]. default is aspect_fill.
     * bg_color: hex code for rgb color (i.e. rrggbb).
 */
@interface SMImageView : UIImageView <SMViewElement>

@end