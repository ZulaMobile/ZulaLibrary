//
//  SMCustomAdvertisementModule.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMComponentModule.h"

/**
 *  Custom advertisement module is responsible of displaying custom advertisements.
 *  Ads can be in 2 forms: Interstitial and Banner adverts.
 */
@interface SMCustomAdvertisementModule : NSObject <SMComponentModule>

/**
 *  Fetches the interstitial (fullscreen) advert that matches the keyword
 *  If found, displays it modally. If not does nothing
 *
 *  @param keyword A keyword that determines the advert
 */
- (void)displayInterstitialAdvertForKeyword:(NSString *)keyword;

/**
 *  Fetches the interstitial (fullscreen) advert that matches the keyword
 *  If found, displays it. If not does nothing
 *
 *  @param keyword A keyword that determines the advert
 */
- (void)displayBannerAdvertForKeyword:(NSString *)keyword;

@end
