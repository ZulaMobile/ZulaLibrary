//
//  SMFormTextArea.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormTextArea.h"
#import "SSTextView.h"

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
    static NSString* CellIdentifier = @"FormTextAreaReuseIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SSTextView *textView;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // cell appearances
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // text field
        
        textView = [[SSTextView alloc] init];
        textView.tag = 661;
        textView.keyboardType = UIKeyboardTypeDefault;
        [textView setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [(SSTextView *)textView setDelegate:self];
        
        [cell.contentView addSubview:textView];
    }
    
    if (!textView)
        textView = (SSTextView *)[cell.contentView viewWithTag:661];
    
    [textView setFrame:CGRectMake(0,
                                   0,
                                   CGRectGetWidth(tableView.frame) - 40,
                                   self.height - 14)];
    [textView setPlaceholder:self.label];
    
    return cell;
}


- (BOOL)isDataField
{
    return YES;
}

- (NSString *)data
{
    NSString *text = [(UITextView *)self.field text];
    return (text) ? text : @"";
}

#pragma mark - delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(fieldDidBecameActive:)]) {
        [self.delegate fieldDidBecameActive:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(fieldDidBecameInactive:)]) {
        [self.delegate fieldDidBecameInactive:self];
    }
}

@end
