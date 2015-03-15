//
//  SMAdvertTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "GHUnit.h"
#import "SMAdvert.h"
#import "SMBannerAdvert.h"
#import "SMInterstitialAdvert.h"


@interface SMAdvertTests : GHTestCase
@end

@implementation SMAdvertTests

- (void)testInterstitialAdvertCreationFromDictionary
{
    NSDictionary *dict = @{@"advert_type": @"Interstitial",
                           @"content_type": @"Image",
                           @"url": @"http://www.mydomain.com/some.png",
                           @"keywords": @[@"SPLASH"]};
    
    SMInterstitialAdvert *ad = [[SMInterstitialAdvert alloc] initWithDictionary:dict];
    GHAssertEquals(ad.contentType, SMAdvertTypeImage, @"advert content type is incorrect");
    GHAssertEqualStrings(ad.url, @"http://www.mydomain.com/some.png", @"advert url is incorrect");
    
    dict = @{@"advert_type": @"Interstitial",
               @"content_type": @"Video",
               @"url": @"http://www.mydomain.com/some.mov",
               @"keywords": @[@"SPLASH"]};
    
    ad = [[SMInterstitialAdvert alloc] initWithDictionary:dict];
    GHAssertEquals(ad.contentType, SMAdvertTypeVideo, @"advert content type is incorrect");
    GHAssertEqualStrings(ad.url, @"http://www.mydomain.com/some.mov", @"advert url is incorrect");
    
    dict = @{@"advert_type": @"Interstitial",
                           @"content_type": @"HTML",
                           @"url": @"http://www.mydomain.com/some.html",
                           @"keywords": @[@"SPLASH"]};
    
    ad = [[SMInterstitialAdvert alloc] initWithDictionary:dict];
    GHAssertEquals(ad.contentType, SMAdvertTypeHTML, @"advert content type is incorrect");
    GHAssertEqualStrings(ad.url, @"http://www.mydomain.com/some.html", @"advert url is incorrect");
}

- (void)testBannerAdvertCreationFromDictionary
{
    NSDictionary *dict = @{@"advert_type": @"Banner",
                           @"content_type": @"Image",
                           @"url": @"http://www.mydomain.com/some.png",
                           @"keywords": @[@"SPLASH"]};
    
    SMBannerAdvert *ad = [[SMBannerAdvert alloc] initWithDictionary:dict];
    GHAssertEquals(ad.contentType, SMAdvertTypeImage, @"advert content type is incorrect");
    GHAssertEqualStrings(ad.url, @"http://www.mydomain.com/some.png", @"advert url is incorrect");
    
    dict = @{@"advert_type": @"Banner",
             @"content_type": @"Video",
             @"url": @"http://www.mydomain.com/some.mov",
             @"keywords": @[@"SPLASH"]};
    
    ad = [[SMBannerAdvert alloc] initWithDictionary:dict];
    GHAssertNil(ad, @"video is not supported for banner adverts");
    
    dict = @{@"advert_type": @"Banner",
                           @"content_type": @"HTML",
                           @"url": @"http://www.mydomain.com/some.html",
                           @"keywords": @[@"SPLASH"]};
    
    ad = [[SMBannerAdvert alloc] initWithDictionary:dict];
    GHAssertEquals(ad.contentType, SMAdvertTypeHTML, @"advert content type is incorrect");
    GHAssertEqualStrings(ad.url, @"http://www.mydomain.com/some.html", @"advert url is incorrect");
}

@end
