//
//  SMFormTableViewStrategy.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMFormDescription.h"

@protocol SMFormDelegate;
@class SMFormAction, SMFormField;

/**
 Form strategy that manages the form table's data source and delegate
 The strategy stores the fields list that used for creating the form
 */
@interface SMFormTableViewStrategy : NSObject <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate, SMFormDescriptionDelegate>

/**
 Delegates the result of the form
 */
@property (nonatomic, weak) id<SMFormDelegate> delegate;

/**
 Form configuration class that holds fields and configurations (appearance data etc)
 */
@property (nonatomic, strong) SMFormDescription *description;

/**
 Actions are events that run when the form posted. 
 An action can send the form data the server, or email it to the recipients.
 */
@property (nonatomic, strong) SMFormAction *action;

/**
 Initialize with a description class that holds configuration. Table delegate and strategy will
 create a form for the tableView.
 */
- (id)initWithDescription:(SMFormDescription *)formDescription;

/**
 Initialize with configuration dictionary. Table delegate and strategy will
 create a form for the tableView.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

/**
 Initialize with a description class that holds configuration. Table delegate and strategy will
 create a form for the tableView.
 
 If scroll view (which contains the tableView) is added, this class will adjust
 the content positions automatically.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary scrollView:(UIScrollView *)scrollView;

/**
 Initialize with configuration dictionary. Table delegate and strategy will
 create a form for the tableView.
 
 If scroll view (which contains the tableView) is added, this class will adjust
 the content positions automatically.
 */
- (id)initWithDescription:(SMFormDescription *)formDescription scrollView:(UIScrollView *)scrollView;

@end

/******
 Delegate
 *******/

@protocol SMFormDelegate <NSObject>

@optional
- (void)form:(SMFormTableViewStrategy *)strategy didStartActionFromField:(SMFormField *)field;
- (void)form:(SMFormTableViewStrategy *)strategy didFailFromField:(SMFormField *)field;
- (void)form:(SMFormTableViewStrategy *)strategy didSuccesFromField:(SMFormField *)field;

/**
 Override point for adjusting the scrollview offset when activating a field.
 The default behavior adjusts the scrollview position to the place where active field displays on top of the screen.
 This method is only triggered if the scrollview is set.
 
 Return NO if you want to override the default behavior.
 */
- (BOOL)formShouldAdjustScrollOffset:(SMFormTableViewStrategy *)strategy;

/**
 Triggers when any field in the form is activated. 
 This also means that the keyboard is activated
 */
- (void)formDidStartEditing:(SMFormTableViewStrategy *)strategy;

/**
 Triggers when the editing of the form is finished.
 */
- (void)formDidEndEditing:(SMFormTableViewStrategy *)strategy;

@end
