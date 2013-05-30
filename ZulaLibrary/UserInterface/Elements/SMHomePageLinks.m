//
//  SMHomePageLinks.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMHomePageLinks.h"
#import "UIColor+SSToolkitAdditions.h"
#import "SMAppDelegate.h"
#import "SMNavigation.h"
#import "SMButton.h"
#import "SMAppDescription.h"
#import "SMNavigationDescription.h"

@interface SMHomePageLinks()
- (void)appearanceForVisibility:(NSString *)visibility;
- (void)appearanceForStyle:(NSString *)style;
- (void)appearanceForButtonColor:(NSString *)buttonColor;
- (void)onComponentButton:(UIButton *)sender;
@end

@implementation SMHomePageLinks
@synthesize padding;

- (void)applyAppearances:(NSDictionary *)appearances
{
    if (!padding) {
        padding = 10.0;
    }
    [self appearanceForVisibility:[appearances objectForKey:@"disable"]];
    [self appearanceForStyle:[appearances objectForKey:@"style"]];
    [self appearanceForButtonColor:[appearances objectForKey:@"button_color"]];
}

#pragma mark - private methods

- (void)appearanceForVisibility:(NSString *)visibility
{
    if ([visibility isEqualToString:@"1"]) {
        [self setHidden:NO];
    }
    
    if ([visibility isEqualToString:@"0"]) {
        [self setHidden:YES];
    }
}

- (void)appearanceForStyle:(NSString *)style
{
    if (!style) {
        style = @"list";
    }
    
    if ([style isEqualToString:@"list"]) {
        // place links
        UIResponder<SMAppDelegate> *appDelegate = (UIResponder<SMAppDelegate> *)[[UIApplication sharedApplication] delegate];
        UIViewController<SMNavigation> *navigation = (UIViewController<SMNavigation> *)[appDelegate navigationComponent];
        int i = 0, j = 0;
        for (UIViewController *component in navigation.components) {
            // if it is a navigation controller, we disable them to show up in the homepage links
            // this will prevent the error of pushing navigation controller
            // also this will allow us to disable menu in tabbar navigation
            if ([component isKindOfClass:[UINavigationController class]]) {
                i++;
                continue;
            }
            // place each component buttons
            SMButton *componentButton = [SMButton buttonWithType:UIButtonTypeCustom];
            [componentButton setFrame:CGRectMake(0,
                                                 j * (40 + self.padding),
                                                 CGRectGetWidth(self.frame),
                                                 40)];
            [componentButton setTag:i];
            [componentButton addTarget:self action:@selector(onComponentButton:) forControlEvents:UIControlEventTouchUpInside];
            [componentButton setTitle:component.title forState:UIControlStateNormal];
            
            [self addSubview:componentButton];
            i++; j++;
        }
        CGRect tmpFrame = self.frame;
        tmpFrame.size.height = j * (40 + self.padding) + self.padding;
        [self setFrame:tmpFrame];
    }
    
    if ([style isEqualToString:@"grid"]) {
        // @todo
        DDLogError(@"Grid homepage links is not yet developed. %@", [self class]);
    }
}

- (void)appearanceForButtonColor:(NSString *)buttonColor
{
    if (!buttonColor) {
        buttonColor = @"CCCCCC";
    }
    
    NSArray *subviews = [self subviews];
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:[SMButton class]]) {
            // get the button colors if set
            [(SMButton *)subview setBackgroundColor:[UIColor colorWithHex:buttonColor]];
        }
    }
}

- (void)onComponentButton:(UIButton *)sender
{
    [self setSelectedIndex:sender.tag];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
