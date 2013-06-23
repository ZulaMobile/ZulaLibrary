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

#import "UILabel+SMAdditions.h"
#import "SMImageView.h"
#import "SMAppearanceValidator.h"

@interface SMImageView()
- (void)appearanceForAlignment:(NSString *)alignment;
- (void)appearanceForBackgroundColorHex:(NSString *)colorHex;
- (void)appearanceForCaption:(NSString *)caption;
- (void)rescaleImage;
@end

@implementation SMImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setClipsToBounds:YES];
        
        [self setUserInteractionEnabled:YES];
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self) {
        if ([self.delegate respondsToSelector:@selector(imageDidTouch:)]) {
            [self.delegate imageDidTouch:self];
        }
    }
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

-(NSString *) stringByStrippingHTML:(NSString *)html {
    NSRange r;
    //NSString *s = [[self copy] autorelease];
    NSString *s = [NSString stringWithString:html];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (void)appearanceForCaption:(NSString *)caption
{
    // adds a caption text on image
    if (!caption) {
        return;
    }
    
    UIWebView *captionWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            CGRectGetWidth(self.frame),
                                                                            CGRectGetHeight(self.frame))];
    [captionWebView setOpaque:NO];
    [captionWebView setBackgroundColor:[UIColor clearColor]];
    [captionWebView setUserInteractionEnabled:NO];
    
    [captionWebView loadHTMLString:caption baseURL:[NSURL URLWithString:@"http://www.zulamobile.com"]];
    [captionWebView setDelegate:self];
    [self addSubview:captionWebView];
}

#pragma mark - web view delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    frame.origin.y = CGRectGetHeight(self.frame) - fittingSize.height;
    webView.frame = frame;
}

#pragma mark - image methods

- (void)addFrame
{
    CALayer *layer = self.layer;
    [layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [layer setBorderWidth:4.0f];
    [layer setShadowColor: [[UIColor colorWithHex:@"333333"] CGColor]];
    [layer setShadowOpacity:0.5f];
    [layer setShadowOffset: CGSizeMake(1, 1)];
    [layer setShadowRadius:1.0];
    [self setClipsToBounds:NO];
    
    [self rescaleImage];
}

- (void)rescaleImage
{
    UIImage* scaledImage = self.image;
    
    CALayer* layer = self.layer;
    CGFloat borderWidth = layer.borderWidth;
    
    //if border is defined
    if (borderWidth > 0)
    {
        //rectangle in which we want to draw the image.
        CGRect imageRect = CGRectMake(0.0, 0.0, self.bounds.size.width - 2 * borderWidth,self.bounds.size.height - 2 * borderWidth);
        //Only draw image if its size is bigger than the image rect size.
        if (self.image.size.width > imageRect.size.width || self.image.size.height > imageRect.size.height)
        {
            UIGraphicsBeginImageContext(imageRect.size);
            [self.image drawInRect:imageRect];
            scaledImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    self.image = scaledImage;
}

@end
