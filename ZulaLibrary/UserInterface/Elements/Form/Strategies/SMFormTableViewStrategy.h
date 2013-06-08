//
//  SMFormTableViewStrategy.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMFormDelegate;
@class SMFormAction, SMFormDescription;

/**
 Form strategy that manages the form table's data source and delegate
 The strategy stores the fields list that used for creating the form
 */
@interface SMFormTableViewStrategy : NSObject <UITableViewDataSource, UITableViewDelegate>

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
 Initialize with a description class that holds configuration
 */
- (id)initWithDescription:(SMFormDescription *)formDescription;

/**
 Initialize with configuration dictionary
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

/******
 Delegate
 *******/

@protocol SMFormDelegate <NSObject>

- (void)formDidStartAction:(SMFormTableViewStrategy *)strategy;
- (void)formDidFail:(SMFormTableViewStrategy *)strategy;
- (void)formDidSuccess:(SMFormTableViewStrategy *)strategy;

@end
