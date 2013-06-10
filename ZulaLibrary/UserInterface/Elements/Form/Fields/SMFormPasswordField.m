//
//  SMFormPasswordField.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormPasswordField.h"

@implementation SMFormPasswordField

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString* CellIdentifier = @"FormPasswordFieldReuseIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    float padding = 10.0f;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // cell appearances
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // text field
        
        self.field = [[UITextField alloc] init];
        [(UITextField *)self.field setSecureTextEntry:YES];
        [(UITextField *)self.field setDelegate:self];
        self.field.tag = 661;
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
