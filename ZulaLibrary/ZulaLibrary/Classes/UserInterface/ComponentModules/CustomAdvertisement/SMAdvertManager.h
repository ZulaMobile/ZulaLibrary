//
//  SMAdvertManager.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMInterstitialAdvert, SMBannerAdvert;

@interface SMAdvertManager : NSObject

@property (nonatomic) NSInteger interval;

@property (nonatomic) NSInteger refreshInterval;

@property (nonatomic, strong) NSArray *interstitialAdverts;
@property (nonatomic, strong) NSArray *bannerAdverts;

+ (instancetype)sharedInstance;

- (SMInterstitialAdvert *)nextInterstitialAdvert;
- (SMBannerAdvert *)nextBannerAdvert;

- (SMInterstitialAdvert *)nextInterstitialAdvertForKeyword:(NSString *)keyword;
- (SMBannerAdvert *)nextBannerAdvertForKeyword:(NSString *)keyword;

@end
