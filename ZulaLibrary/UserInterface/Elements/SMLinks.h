//
//  SMHomePageLinks.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewElement.h"

@interface SMLinks : UIControl <SMViewElement>

/**
 The padding of each link
 */
@property (nonatomic) NSInteger padding;

/**
 Selected component index
 */
@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic) NSArray *componentTitles;

- (void)onComponentButton:(UIButton *)sender;

@end

@protocol SMLinkStrategy <NSObject>

////////

@property (nonatomic, weak) SMLinks *links;

- (id)initWithLinks:(SMLinks *)links;

/**
 *  Initial setup of the class. This is triggerrred before applyAppearances and after init
 */
- (void)setup;

/**
 *  The hook to apply necessary appearances
 */
- (void)applyAppearances:(NSDictionary *)appearances;

@end