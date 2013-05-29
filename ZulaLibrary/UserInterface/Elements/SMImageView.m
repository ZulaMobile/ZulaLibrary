//
//  SMImageView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIColor+SSToolkitAdditions.h"
#import <CoreText/CoreText.h>
#import "DTCoreText.h"

#import "UILabel+SMAdditions.h"
#import "SMImageView.h"
#import "SMAppearanceValidator.h"

@interface SMImageView()
- (void)appearanceForAlignment:(NSString *)alignment;
- (void)appearanceForBackgroundColorHex:(NSString *)colorHex;
- (void)appearanceForCaption:(NSString *)caption;
@end

@implementation SMImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setClipsToBounds:YES];
    }
    return self;
}

/**
 image view settings, Current available options are:
    * alignment: the content mode [center, left, right, aspect_fill, aspect_fit]. default is aspect_fill
    * bg_color
 */
- (void)applyAppearances:(NSDictionary *)appearances
{
    if (![SMAppearanceValidator isValidData:appearances]) {
        //DDLogError(@"Image data is not valid, expects dict: %@", appearances);
        return;
    }
    
    // set appearances
    [self appearanceForAlignment:[appearances objectForKey:@"alignment"]];
    [self appearanceForBackgroundColorHex:[appearances objectForKey:@"bg_color"]];
    [self appearanceForCaption:[appearances objectForKey:@"caption"]];
}

#pragma mark - appearance helpers

- (void)appearanceForAlignment:(NSString *)alignment
{
    // default value
    if (!alignment)
        alignment = @"aspect_fill";
    
    if ([alignment isEqualToString:@"left"]) {
        [self setContentMode:UIViewContentModeLeft];
    } else if ([alignment isEqualToString:@"right"]) {
        [self setContentMode:UIViewContentModeRight];
    } else if ([alignment isEqualToString:@"center"]) {
        [self setContentMode:UIViewContentModeCenter];
    } else if ([alignment isEqualToString:@"aspect_fit"]) {
        [self setContentMode:UIViewContentModeScaleAspectFit];
    } else if ([alignment isEqualToString:@"aspect_fill"]) {
        [self setContentMode:UIViewContentModeScaleAspectFill];
    }
}

- (void)appearanceForBackgroundColorHex:(NSString *)colorHex
{
    // default value
    if (!colorHex) {
        colorHex = @"clean";
    }
    
    if ([colorHex isEqualToString:@"clean"] || [colorHex isEqualToString:@""]) {
        [self setBackgroundColor:[UIColor clearColor]];
    } else {
        [self setBackgroundColor:[UIColor colorWithHex:colorHex]];
    }
}

- (void)setImageWithUrlString:(NSString *)url
{
    if (!url) {
        return;
    }
    
    NSURL *imageUrl = [NSURL URLWithString:url];
    if (!imageUrl) {
        return;
    }
    
    [self setImageWithURL:imageUrl];
}

- (void)appearanceForCaption:(NSString *)caption
{
    // adds a caption text on image
    if (!caption) {
        return;
    }
    
    NSString *fontName = @"Helvetica";
    float fontSize = 12;
    CGSize textSize = [caption sizeWithFont:[UIFont fontWithName:fontName size:fontSize] constrainedToSize:self.frame.size lineBreakMode:NSLineBreakByTruncatingTail];
    /*
    UILabel *captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2 - textSize.width / 2,
                                                                      CGRectGetHeight(self.frame) - textSize.height - 10.0,
                                                                      320,
                                                                      textSize.height)];
    [captionLabel setText:caption];
    [captionLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [captionLabel setBackgroundColor:[UIColor clearColor]];
    [captionLabel setTextAlignment:NSTextAlignmentCenter];
    [captionLabel setTextColor:[UIColor whiteColor]];
    [captionLabel setShadowColor:[UIColor blackColor]];
    [captionLabel setShadowOffset:CGSizeMake(0, -1)];
    [captionLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [captionLabel setNumberOfLines:0];
    [captionLabel sizeToFit];
    
    // add glow
    [captionLabel addGlow:[UIColor blackColor]];
    
    [self addSubview:captionLabel];
    */
    
    NSString *styledCaption = [NSString stringWithFormat:@"<style>.image-caption {text-align: center;font-family: Helvetica, sans-serif; color: white; text-shadow: black 1px 1px; font-weight:bold; }</style><div class='image-caption'>%@</div>", caption];
    NSData *data = [styledCaption dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:nil];
    
    DTAttributedLabel *captionLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(0,
                                                                                          CGRectGetHeight(self.frame) - textSize.height,
                                                                                          320,
                                                                                          textSize.height)];
    [captionLabel setAttributedString:attributedString];
    [captionLabel setBackgroundColor:[UIColor clearColor]];
    [captionLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [captionLabel setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    //[captionLabel setNumberOfLines:0];
    //[captionLabel sizeToFit];
    
    [self addSubview:captionLabel];
}

@end
