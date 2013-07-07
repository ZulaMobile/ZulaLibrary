//
//  SMFormField.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMFormFieldDelegate;
@class SMFormDescription;

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
 Properties
 *********************************************************/

/**
 The ui field that holds the data.
 */
@property (nonatomic) UIView *field;

/**
 An array consists of objects that subclass `SMFormValidator`.
 */
@property (nonatomic, strong) NSArray *validators;

/**
 Delegate
 */
@property (nonatomic, weak) id<SMFormFieldDelegate> delegate;

/**
 The height of the field
 */
@property (nonatomic) float height;

/**
 Form field's data, this is usually filled by the user. For example, 
 if it is a text field, the text fields text value will be returned.
 */
@property (nonatomic) NSString *data;

/*********************************************************
 Messages
 *********************************************************/

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

/**
 Returns YES is field can store data
 */
- (BOOL)isDataField;

/**
 Returns YES if there is an attached action to this field
 */
- (BOOL)hasAction;

- (void)endEditing:(BOOL)animated;

/**
 Executes the attached action and returns in the completion block
 */
- (void)executeActionWithDescription:(SMFormDescription *)description
                   completion:(void(^)(NSError *error))completion;

@end

/*********************************************************
 Delegate
 *********************************************************/

@protocol SMFormFieldDelegate <NSObject>

@optional

/**
 Fired when the field become first responder
 */
- (void)fieldDidBecameActive:(SMFormField *)field;

/**
 Fired when the field resigns being first responder
 */
- (void)fieldDidBecameInactive:(SMFormField *)field;

/**
 Fired when the next return key on the keyboard is pressed
 */
- (BOOL)field:(SMFormField *)field shouldReturnWithReturnKeyType:(UIReturnKeyType)returnKeyType;

@end
