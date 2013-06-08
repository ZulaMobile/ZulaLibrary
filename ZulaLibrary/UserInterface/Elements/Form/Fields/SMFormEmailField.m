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
    static NSString* CellIdentifier = @"FormTextFieldReuseIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITextField *textField;
    float padding = 10.0f;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // cell appearances
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // text field
        
        textField = [[UITextField alloc] init];
        textField.tag = 661;
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        
        [cell.contentView addSubview:textField];
    }
    
    if (!textField)
        textField = (UITextField *)[cell.contentView viewWithTag:661];
    
    [textField setFrame:CGRectMake(padding + self.labelWidth,
                                   padding,
                                   CGRectGetWidth(tableView.frame) - 40,
                                   30)];
    
    // label
    if (self.labelWidth == 0) {
        [cell.textLabel setText:@""];
        [textField setPlaceholder:self.label];
    } else if (self.label) {
        [cell.textLabel setText:self.label];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    }
    
    return cell;
}

@end
