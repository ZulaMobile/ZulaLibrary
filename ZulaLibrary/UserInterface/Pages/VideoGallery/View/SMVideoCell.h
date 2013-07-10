//
//  SMVideoCell.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/29/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMVideoCell : UITableViewCell

@property (nonatomic, strong) UILabel *videoLabel;
@property (nonatomic, strong) UIWebView *videoView;

- (void)showVideoWithUrl:(NSURL *)url;

@end
