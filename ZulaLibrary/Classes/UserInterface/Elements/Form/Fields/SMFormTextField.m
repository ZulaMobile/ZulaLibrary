//
//  SMFormTextField.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormTextField.h"

@implementation SMFormTextField
@synthesize labelWidth;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        [self setHeight:44.0f];
        self.labelWidth = 0;
    }
    return self;
}

- (BOOL)isValid
{
    return YES;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString* CellIdentifier = @"FormTextFieldReuseIdentifier";
    
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
        
        if (self.appearances && [self.appearances objectForKey:@"return_key"]) {
            NSInteger key = [[self.appearances objectForKey:@"return_key"] integerValue];
            [(UITextField *)self.field setReturnKeyType:key];
        } else {
            [(UITextField *)self.field setReturnKeyType:UIReturnKeyNext];
        }
        
        if (self.appearances && [self.appearances objectForKey:@"clear_button_mode"]) {
            NSInteger key = [[self.appearances objectForKey:@"clear_button_mode"] integerValue];
            [(UITextField *)self.field setClearButtonMode:key];
        } else {
            [(UITextField *)self.field setClearButtonMode:UITextFieldViewModeWhileEditing];    
        }
        
        if (self.appearances && [self.appearances objectForKey:@"auto_capitalization_type"]) {
            NSInteger key = [[self.appearances objectForKey:@"auto_capitalization_type"] integerValue];
            [(UITextField *)self.field setAutocapitalizationType:key];
        } else {
            [(UITextField *)self.field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        }
        
        if (self.appearances && [self.appearances objectForKey:@"auto_correction_type"]) {
            NSInteger key = [[self.appearances objectForKey:@"auto_correction_type"] integerValue];
            [(UITextField *)self.field setAutocapitalizationType:key];
        } else {
            [(UITextField *)self.field setAutocorrectionType:UITextAutocorrectionTypeNo];
        }
        
        [cell.contentView addSubview:self.field];
    }
    
    if (!self.field)
        self.field = (UITextField *)[cell.contentView viewWithTag:661];
    
    [self.field setFrame:CGRectMake(padding + self.labelWidth,
                                  padding,
                                  CGRectGetWidth(tableView.frame) - 40,
                                   self.height - 14)];
    
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

- (BOOL)isDataField
{
    return YES;
}

- (NSString *)data
{
    NSString *text = [(UITextField *)self.field text];
    return (text) ? text : [super data];
}

- (void)setData:(NSString *)data
{
    [super setData:data];
    
    [(UITextField *)self.field setText:data];
}

#pragma mark - text view delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(fieldDidBecameActive:)]) {
        [self.delegate fieldDidBecameActive:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(fieldDidBecameInactive:)]) {
        [self.delegate fieldDidBecameInactive:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(field:shouldReturnWithReturnKeyType:)]) {
        return [self.delegate field:self shouldReturnWithReturnKeyType:textField.returnKeyType];
    }
    
    // default behavior
    [self endEditing:YES];
    return YES;
}

@end
