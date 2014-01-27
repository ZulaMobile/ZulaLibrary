//
//  SMLinksButtonsStrategy.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMLinksButtonsStrategy.h"
#import "UIColor+ZulaAdditions.h"
#import "SMAppDelegate.h"
#import "SMButton.h"
#import "SMComponentDescription.h"
#import "SMNavigationDescription.h"

@interface SMLinksButtonsStrategy ()
- (void)appearanceForButtonColor:(NSString *)buttonColor;
- (void)onComponentButton:(UIButton *)sender;
@end

@implementation SMLinksButtonsStrategy
@synthesize links;

- (id)initWithLinks:(SMLinks *)aLinksObject
{
    self = [super init];
    if (self) {
        self.links = aLinksObject;
        
        if (!self.links.padding) {
            self.links.padding = 10.0f;
            CGRect fr = self.links.frame;
            fr.origin.x = 10.0f;
            fr.origin.y = 10.0f;
            self.links.frame = fr;
        }
    }
    return self;
}

- (void)setup
{
    // place links
    int i = 0, j = 0;
    
    for (NSString *title in self.links.componentTitles) {
        // place each component buttons
        SMButton *componentButton = [SMButton buttonWithType:UIButtonTypeCustom];
        [componentButton setFrame:CGRectMake(0,
                                             j * (40 + self.links.padding),
                                             CGRectGetWidth(self.links.frame),
                                             40)];
        [componentButton setTag:i];
        [componentButton addTarget:self action:@selector(onComponentButton:) forControlEvents:UIControlEventTouchUpInside];
        [componentButton setTitle:title forState:UIControlStateNormal];
        
        [self.links addSubview:componentButton];
        i++; j++;
    }
    CGRect tmpFrame = self.links.frame;
    tmpFrame.size.height = j * (40 + self.links.padding) + self.links.padding;
    [self.links setFrame:tmpFrame];
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    [self appearanceForButtonColor:[appearances objectForKey:@"button_color"]];
}

- (void)appearanceForButtonColor:(NSString *)buttonColor
{
    if (!buttonColor) {
        buttonColor = @"CCCCCC";
    }
    
    NSArray *subviews = [self.links subviews];
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:[SMButton class]]) {
            // get the button colors if set
            [(SMButton *)subview setBackgroundColor:[UIColor colorWithHex:buttonColor]];
        }
    }
}

- (void)onComponentButton:(UIButton *)sender
{
    [self.links onComponentButton:sender];
}

@end
