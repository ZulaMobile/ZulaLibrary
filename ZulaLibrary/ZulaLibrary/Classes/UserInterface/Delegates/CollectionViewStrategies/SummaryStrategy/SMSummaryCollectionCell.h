//
//  SMSummaryCollectionCell.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 19/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"

#define PADDING 10.0f;

@interface SMSummaryCollectionCell : UICollectionViewCell <SMViewElement>

@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *summary;

- (float)height;
- (void)adjustFrames;

@end


@interface SMSummaryCollectionImageCell : SMSummaryCollectionCell <SMViewElement>

@property (nonatomic, strong) UIImageView *image;

@end
