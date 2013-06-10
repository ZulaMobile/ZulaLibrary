//
//  SMFormTableViewStrategy.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMFormDelegate;
@class SMFormAction, SMFormDescription, SMFormField;

/**
 Form strategy that manages the form table's data source and delegate
 The strategy stores the fields list that used for creating the form
 */
@interface SMFormTableViewStrategy : NSObject <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>

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

@end
