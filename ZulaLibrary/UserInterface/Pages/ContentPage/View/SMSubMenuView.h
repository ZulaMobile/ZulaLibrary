//
//  SMSubMenuView.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/20/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"

/**
 Sub Menu View is a horizontally scrollable menu.
 It has multiple UIButton items.
 */
@interface SMSubMenuView : UIControl <SMViewElement>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic) UIButton *activeButton;

- (void)addButtonWithTitle:(NSString *)title tag:(NSInteger)tag;
- (UIButton *)buttonWithTag:(NSInteger)tag;

@end
