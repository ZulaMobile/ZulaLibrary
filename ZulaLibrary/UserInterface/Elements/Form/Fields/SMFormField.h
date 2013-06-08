//
//  SMFormField.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Configuration attribute keys
 */
#define kFormFieldName @"name"
#define kFormFieldLabel @"label"

/*********************************************************
 Properties that hold data
 *********************************************************/

/**
 Base field class. All the form fields must subclass this class. 
 SMFormField shouldn't be used without subclassing
 */
@interface SMFormField : NSObject

/**
 The distinct name of the field. The name must be uniquein the form.
 */
@property (nonatomic, strong) NSString *name;

/**
 Optional label text to display on either UILabelView or as a placeholder.
 If not set, the `name` attribute will be used.
 */
@property (nonatomic, strong) NSString *label;

/*********************************************************
 Properties that are not bound to data
 *********************************************************/

/**
 Set if you want to display a label view.
 Default is 0, that is no label, use placeholder text.
 */
@property (nonatomic) float labelWidth;

/**
 The ui field that holds the data.
 */
@property (nonatomic) UIView *field;

/**
 An array consists of objects that subclass `SMFormValidator`.
 */
@property (nonatomic, strong) NSArray *validators;

/**
 The height of the field
 */
@property (nonatomic) float height;

/**
 Initialize a form element using a dict configuration
 */
- (id)initWithAttributes:(NSDictionary *)attributes;

/**
 Executes validators against the field data
 and returns Boolean
 */
- (BOOL)isValid;

/**
 Returns reused table view cell with data modifications
 */
- (UITableViewCell *)cellForTableView:(UITableView *)tableView;

@end
