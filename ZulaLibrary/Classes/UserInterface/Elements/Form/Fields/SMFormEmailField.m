//
//  SMFormEmailField.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormEmailField.h"

@implementation SMFormEmailField

- (BOOL)isValid
{
    // check for email validity
    return YES;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString* CellIdentifier = @"FormEmailFieldReuseIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    float padding = 10.0f;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // cell appearances
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // text field
        
        self.field = [[UITextField alloc] init];
        self.field.tag = 661;
        [(UITextField *)self.field setDelegate:self];
        [(UITextField *)self.field setKeyboardType:UIKeyboardTypeEmailAddress];
        
        [cell.contentView addSubview:self.field];
    }
    
    if (!self.field)
        self.field = (UITextField *)[cell.contentView viewWithTag:661];
    
    [self.field setFrame:CGRectMake(padding + self.labelWidth,
                                   padding,
                                   CGRectGetWidth(tableView.frame) - 40,
                                   30)];
    
    // label
    if (self.labelWidth == 0) {
        [cell.textLabel setText:@""];
        [(UITextField *)self.field setPlaceholder:self.label];
    } else if (self.label) {
        [cell.textLabel setText:self.label];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    }
    
    return cell;
}

@end
