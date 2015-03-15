//
//  SMCustomAdvertisementModuleTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "GHUnit.h"
#import "SMCustomAdvertisementModule.h"
#import "SMAdvertManager.h"
#import "SMInterstitialAdvert.h"
#import "SMBannerAdvert.h"
#import "SMAdvert.h"

@interface SMAdvertManager ()
- (void)setupWithData:(NSDictionary *)data;
@end


@interface SMCustomAdvertisementModuleTests : GHTestCase
@end

@implementation SMCustomAdvertisementModuleTests
{
    NSDictionary *ad1;
    NSDictionary *ad2;
    NSDictionary *ad3;
}

- (void)setUp
{
    ad1 = @{@"advert_type": @"Interstitial",
            @"content_type": @"Image",
            @"url": @"http://www.mydomain.com/some.png",
            @"keywords": @[@"SPLASH"]};
    
    ad2 = @{@"advert_type": @"Interstitial",
            @"content_type": @"Image",
            @"url": @"http://www.mydomain.com/some2.png",
            @"keywords": @[@"ALL"]};
    
    ad3 = @{@"advert_type": @"Banner",
            @"content_type": @"Image",
            @"url": @"http://www.mydomain.com/some3.png",
            @"keywords": @[@"My Content"]};
}

- (void)testCreatingAdverts
{
    NSDictionary *dict = @{@"refresh_interval": @"90",
                           @"interval": @"180",
                           @"ads": @[ad1, ad2, ad3]};
    
    SMAdvertManager *manager = [[SMAdvertManager alloc] init];
    [manager setupWithData:dict];
    
    GHAssertTrue(2 == [manager.interstitialAdverts count], @"adverts should've been added");
    GHAssertTrue(1 == [manager.bannerAdverts count], @"adverts should've been added");
    GHAssertTrue([[manager.interstitialAdverts objectAtIndex:0] isKindOfClass:[SMInterstitialAdvert class]], nil);
    GHAssertTrue([[manager.interstitialAdverts objectAtIndex:1] isKindOfClass:[SMInterstitialAdvert class]], nil);
    GHAssertTrue([[manager.bannerAdverts objectAtIndex:0] isKindOfClass:[SMBannerAdvert class]], nil);
    GHAssertEquals(90, manager.refreshInterval, nil);
    GHAssertEquals(180, manager.interval, nil);
}

@end
