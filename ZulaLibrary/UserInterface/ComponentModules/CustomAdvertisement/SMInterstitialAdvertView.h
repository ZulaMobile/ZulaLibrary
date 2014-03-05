//
//  SMInterstitialAdvertView.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMInterstitialAdvert;

@interface SMInterstitialAdvertView : UIControl

@property (nonatomic, strong) SMInterstitialAdvert *model;

- (id)initWithAdvert:(SMInterstitialAdvert *)advert;

@end
