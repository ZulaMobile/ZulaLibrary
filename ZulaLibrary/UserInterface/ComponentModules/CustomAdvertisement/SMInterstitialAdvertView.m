//
//  SMInterstitialAdvertView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 01/02/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMInterstitialAdvertView.h"
#import "SMInterstitialAdvert.h"
#import "UIImageView+WebCache.h"


@interface SMInterstitialAdvertView ()

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

- (void)setupHtmlContent;
- (void)setupImageContent;
- (void)setupVideoContent;

- (void)setupCloseButton;
- (void)onCloseButton;

- (void)setupIndicator;

@end


@implementation SMInterstitialAdvertView

- (id)initWithAdvert:(SMInterstitialAdvert *)advert
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.model = advert;
        
        [self setupIndicator];
        
        if (advert.contentType == SMAdvertTypeImage) {
            [self setupImageContent];
        } else if (advert.contentType == SMAdvertTypeVideo) {
            [self setupVideoContent];
        } else if (advert.contentType == SMAdvertTypeHTML) {
            [self setupHtmlContent];
        }
        [self setupCloseButton];
        
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

#pragma mark - private methods

- (void)setupImageContent
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
    //[imageView setImageWithURL:[NSURL URLWithString:self.model.url]];
    [imageView setImageWithURL:[NSURL URLWithString:self.model.url]
                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                         [self.indicator stopAnimating];
                     }];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self addSubview:imageView];
}

- (void)setupHtmlContent
{
    // @TODO
}

- (void)setupVideoContent
{
    // @TODO
}

- (void)setupIndicator
{
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    CGSize size = (CGSize){20.0f, 20.0f};
    self.indicator.frame = CGRectMake(CGRectGetWidth(self.frame) / 2 - size.width / 2, CGRectGetHeight(self.frame) / 2 - size.height / 2, size.width, size.height);
    [self.indicator startAnimating];
    [self.indicator hidesWhenStopped];
    [self addSubview:self.indicator];
}

- (void)setupCloseButton
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    [btn setImage:[UIImage imageNamed:@"zularesources.bundle/close-round-icon"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(onCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)onCloseButton
{
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
