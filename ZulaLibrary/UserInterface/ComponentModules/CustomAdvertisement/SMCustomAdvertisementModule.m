//
//  SMCustomAdvertisementModule.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMCustomAdvertisementModule.h"
#import "SMBaseComponentViewController.h"
#import "SMAdvert.h"
#import "SMInterstitialAdvert.h"
#import "SMBannerAdvert.h"
#import "SMAdvertManager.h"
#import "SMInterstitialAdvertView.h"
#import "SMBannerAdvertView.h"


@interface SMNoStatusBarController : UIViewController
@end

@implementation SMNoStatusBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWantsFullScreenLayout:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end


@interface SMCustomAdvertisementModule ()
- (void)displayInterstitialAdvert:(SMInterstitialAdvert *)advert;
- (void)displayBannerAdvert:(SMBannerAdvert *)advert;
- (void)onInterstitialCloseButton:(id)sender;
- (void)onInterstitialAd:(id)sender;
@end


@implementation SMCustomAdvertisementModule
@synthesize component;

- (id)initWithComponent:(SMBaseComponentViewController *)aComponent
{
    self = [super init];
    if (self) {
        self.component = aComponent;
    }
    return self;
}

#pragma mark - private methods

- (void)displayInterstitialAdvert:(SMInterstitialAdvert *)advert
{
    if (!advert) return;
    
    SMNoStatusBarController *interstitialController = [[SMNoStatusBarController alloc] initWithNibName:nil bundle:nil];
    SMInterstitialAdvertView *adView = [[SMInterstitialAdvertView alloc] initWithAdvert:advert];
    [adView addTarget:self action:@selector(onInterstitialCloseButton:) forControlEvents:UIControlEventValueChanged];
    [adView addTarget:self action:@selector(onInterstitialAd:) forControlEvents:UIControlEventTouchUpInside];
    interstitialController.view = adView;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.component presentViewController:interstitialController
                                 animated:YES
                               completion:^{
                                   
                               }];
}

- (void)displayBannerAdvert:(SMBannerAdvert *)advert
{
    if (!advert) return;
    
    // @TODO
}

- (void)onInterstitialCloseButton:(id)sender
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [self.component dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        }];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self.component dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)onInterstitialAd:(id)sender
{
    if ([sender isKindOfClass:[SMInterstitialAdvertView class]]) {
        SMInterstitialAdvert *advert = [(SMInterstitialAdvertView *)sender model];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:advert.targetUrl]];
    }
    
    [self.component dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
}

#pragma mark - module methods

- (void)componentViewDidLoad
{
    // load interstitial adverts
    SMInterstitialAdvert *interstitial =
    [[SMAdvertManager sharedInstance] nextInterstitialAdvertForKeyword:self.component.title];
    [self displayInterstitialAdvert:interstitial];
    
    // load banner adverts
    SMBannerAdvert *banner =
    [[SMAdvertManager sharedInstance] nextBannerAdvertForKeyword:self.component.title];
    [self displayBannerAdvert:banner];
}

- (void)componentWillFetchContents
{
    
}

- (void)componentDidFetchContent:(SMModel *)model
{
    
}

@end
