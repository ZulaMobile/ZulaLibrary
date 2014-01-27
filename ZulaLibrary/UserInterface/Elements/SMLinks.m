//
//  SMHomePageLinks.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMLinks.h"

#import "SMNavigation.h"
#import "SMAppDescription.h"
#import "SMNavigationDescription.h"
#import "SMLinksTilesStrategy.h"
#import "SMLinksButtonsStrategy.h"


@interface SMLinks()
- (void)appearanceForVisibility:(BOOL)visibility;
- (void)determineStrategyFromStyle:(NSString *)style;

@property (nonatomic, strong) id<SMLinkStrategy> strategy;

@end

@implementation SMLinks
@synthesize padding;

- (void)applyAppearances:(NSDictionary *)appearances
{
    if (!padding) {
        padding = 10.0;
    }
    [self appearanceForVisibility:[[appearances objectForKey:@"disable"] boolValue]];
    [self determineStrategyFromStyle:[appearances objectForKey:@"style"]];
    
    if (self.strategy) {
        [self.strategy setup];
        [self.strategy applyAppearances:appearances];
    }
}

#pragma mark - private methods

- (void)appearanceForVisibility:(BOOL)visibility
{
    [self setHidden:visibility];
}

- (void)determineStrategyFromStyle:(NSString *)style
{
    if (!style) {
        style = @"list";
    }
    
    if ([style isEqualToString:@"list"]) {
        self.strategy = [[SMLinksButtonsStrategy alloc] initWithLinks:self];
    } else if ([style isEqualToString:@"grid"]) {
        // @todo
        DDLogError(@"Grid homepage links is not yet developed. %@", [self class]);
    } else if ([style isEqualToString:@"tiles"]) {
        self.strategy = [[SMLinksTilesStrategy alloc] initWithLinks:self];
    }
}

- (void)onComponentButton:(UIButton *)sender
{
    [self setSelectedIndex:sender.tag];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
