//
//  SMFormTextArea.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormTextArea.h"

@implementation SMFormTextArea

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        [self setHeight:144.0f];
    }
    return self;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString* CellIdentifier = @"FormTextFieldReuseIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITextView *textView;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // cell appearances
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // text field
        
        textView = [[UITextView alloc] init];
        textView.tag = 661;
        textView.keyboardType = UIKeyboardTypeEmailAddress;
        
        [cell.contentView addSubview:textView];
    }
    /*
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
    }*/
    
    return cell;
}

@end
