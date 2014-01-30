//
//  SMSummaryCell.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"


@interface SMSummaryCell : UITableViewCell <SMViewElement>

@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *summary;

- (void)activateDisplayImageView;
- (void)activateNoImageView;

- (float)height;

@end
