//
//  SMSummaryCell.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"

#define PADDING 10.0f;


@interface SMSummaryCell : UITableViewCell <SMViewElement>

@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *summary;

- (float)height;
- (void)adjustFrames;

@end


@interface SMSummaryImageCell : SMSummaryCell

@property (nonatomic, strong) UIImageView *image;

@end
