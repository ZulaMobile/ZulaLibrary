//
//  SMAdvertManager.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMAdvertManager.h"
#import "SMAppDescription.h"
#import "SMAdvert.h"
#import "SMInterstitialAdvert.h"
#import "SMBannerAdvert.h"

@interface SMAdvertManager ()

@property (nonatomic, strong) NSMutableDictionary *keywordAdverts;

- (void)setupWithData:(NSDictionary *)data;
@end


@implementation SMAdvertManager

+ (instancetype)sharedInstance
{
    static SMAdvertManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SMAdvertManager new];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSDictionary *advertisementData =
        [[[SMAppDescription sharedInstance] appDescriptionData] objectForKey:@"advertisement"];
        
        [self setupWithData:advertisementData];
    }
    return self;
}

- (void)setupWithData:(NSDictionary *)advertisementData
{
    self.refreshInterval = ([[SMAppDescription sharedInstance] appDescriptionData]) ?
    [[advertisementData objectForKey:@"refresh_interval"] integerValue] : 180;
    
    self.interval = ([advertisementData objectForKey:@"interval"]) ?
    [[advertisementData objectForKey:@"interval"] integerValue] : 180;
    
    self.keywordAdverts = [[NSMutableDictionary alloc] init];
    
    NSArray *adDataArray = [advertisementData objectForKey:@"ads"];
    NSMutableArray *tmpInterstitial = [[NSMutableArray alloc] initWithCapacity:[adDataArray count]];
    NSMutableArray *tmpBanner = [[NSMutableArray alloc] initWithCapacity:[adDataArray count]];
    for (NSDictionary *adData in adDataArray) {
        NSString *advertType = [adData objectForKey:@"advert_type"];
        SMAdvert *advert;
        if ([advertType isEqualToString:@"Interstitial"]) {
            advert = [[SMInterstitialAdvert alloc] initWithDictionary:adData];
            [tmpInterstitial addObject:advert];
        } else if ([advertType isEqualToString:@"Banner"]) {
            advert = [[SMBannerAdvert alloc] initWithDictionary:adData];
            [tmpBanner addObject:advert];
        }
        
        for (NSString *keyword in advert.keywords) {
            [self.keywordAdverts setObject:advert forKey:keyword];
        }
    }
    self.interstitialAdverts = [NSArray arrayWithArray:tmpInterstitial];
    self.bannerAdverts = [NSArray arrayWithArray:tmpBanner];
}

- (SMInterstitialAdvert *)nextInterstitialAdvert
{
    return ([self.interstitialAdverts count] > 0) ? [self.interstitialAdverts objectAtIndex:0] : nil;
}

- (SMBannerAdvert *)nextBannerAdvert
{
    return nil;
}

- (SMInterstitialAdvert *)nextInterstitialAdvertForKeyword:(NSString *)keyword
{
    // try to find an advert for the keyword
    SMInterstitialAdvert *advert = [self.keywordAdverts objectForKey:keyword];
    if (advert && [advert isKindOfClass:[SMInterstitialAdvert class]]) {
        return advert;
    }
    
    // try to return the ALL
    advert = [self.keywordAdverts objectForKey:@"ALL"];
    if (advert && [advert isKindOfClass:[SMInterstitialAdvert class]]) {
        return advert;
    }
    
    return nil;
}

- (SMBannerAdvert *)nextBannerAdvertForKeyword:(NSString *)keyword
{
    return nil;
}

@end
