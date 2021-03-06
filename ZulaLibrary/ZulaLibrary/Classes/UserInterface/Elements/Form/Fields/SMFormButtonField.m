//
//  SMFormButtonField.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormButtonField.h"
#import <QuartzCore/QuartzCore.h>

#import "SMFormSubmitAction.h"
#import "UIColor+ZulaAdditions.h"

@implementation SMFormButtonField

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        [self setHeight:44.0f];
    }
    return self;
}

- (BOOL)isValid
{
    return YES;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString* CellIdentifier = @"FormButtonFieldReuseIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // cell appearances
        //[cell setBackgroundColor:[UIColor colorWithHex:@"CCCCCC"]];
        [cell.textLabel setTextColor:[UIColor colorWithHex:@"666666"]];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
    [cell.textLabel setText:self.label];
    
    return cell;
}

- (BOOL)hasAction
{
    return YES;
}

- (void)executeActionWithDescription:(SMFormDescription *)description completion:(void (^)(NSError *))completion
{
    SMFormAction *action = [[SMFormSubmitAction alloc] init];
    [action executeActionWithDescription:description completion:completion];
}

@end
