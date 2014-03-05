//
//  SMMapView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/4/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMMapView.h"
#import "UIColor+ZulaAdditions.h"

#import "SMButton.h"
#import "SMAppDescription.h"
#import "SMNavigationDescription.h"

@interface SMMapView()

@property (nonatomic, strong) SMButton *button;
- (void)appearanceForRouteButton:(BOOL)addRouteButton;
- (void)onRoute;
@end

@implementation SMMapView
@synthesize button, routeButtonDelegate;

- (void)applyAppearances:(NSDictionary *)appearances
{
    [self appearanceForRouteButton:[[appearances objectForKey:@"include_route"] boolValue]];
}

#pragma mark - private methods

/**
 Adds `Get Route` Button that gives the route to current location to the destination
 */
- (void)appearanceForRouteButton:(BOOL)addRouteButton
{
    if (!addRouteButton) {
        return;
    }
    
    SMNavigationDescription *navDesc = [[SMAppDescription sharedInstance] navigationDescription];
    NSDictionary *navbar = [[navDesc appearance] objectForKey:@"navbar"];
    NSDictionary *bgImage = [navbar objectForKey:@"bg_image"];
    NSString *bgColor = [bgImage objectForKey:@"bg_color"];

    float width = 80.0;
    float height = 25.0;
    float padding = 5.0;
    self.button = [[SMButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - width - padding, CGRectGetHeight(self.frame) - height - padding, width, height)];
    [self.button setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin];
    [self.button setTitle:NSLocalizedString(@"Get Route", nil) forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(onRoute) forControlEvents:UIControlEventTouchUpInside];
    
    if (bgColor) {
        [self.button setBackgroundColor:[UIColor colorWithHex:bgColor]];
    } else {
        [self.button setBackgroundColor:[UIColor colorWithHex:@"CCCCCC"]];
    }
    
    [self addSubview:self.button];
}

- (void)onRoute
{
    if ([self.routeButtonDelegate respondsToSelector:@selector(onRouteButton:)]) {
        [self.routeButtonDelegate onRouteButton:self];
    }
}

@end
