//
//  SMFormTableViewStrategy.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormTableViewStrategy.h"

#import "SMFormAction.h"
#import "SMFormField.h"
#import "SMFormDescription.h"

@interface SMFormTableViewStrategy()

/**
 Runs when the submit button is tapped.
 Calls the actions to do post business.
 */
- (void)onSubmit;

@end

@implementation SMFormTableViewStrategy
@synthesize description, action;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.description = [[SMFormDescription alloc] initWithDictionary:dictionary];
    }
    return self;
}

- (id)initWithDescription:(SMFormDescription *)formDescription
{
    self = [super init];
    if (self) {
        self.description = formDescription;
    }
    return self;
}

/**
 Renders the fields ui element
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the field object
    SMFormField *field = [self.description.fields objectAtIndex:[indexPath row]];
    
    // get the reuses tableViewCell from the field with necessary data modifications
    UITableViewCell *cell = [field cellForTableView:tableView];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.description.fields.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // in this version, only one section is allowed
    return 1;
}

#pragma mark - table view delegate

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the field
    SMFormField *field = [self.description.fields objectAtIndex:[indexPath row]];
    return [field height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // if it is the submit button, run the action
    if ([indexPath row] == 2) {
        [self onSubmit];
    }
    
}

#pragma mark - private methods

- (void)onSubmit
{
    /*
     // run the action
    [self.action executeWithCompletion:^(NSError *error) {
        if (error) {
            //[self.delegate forDidFail:self];
        }
        //[self.delegate forDidSuccess:self];
    }];*/
}

@end
