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
#import "SMFormSection.h"

@interface SMFormTableViewStrategy()

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
    SMFormField *field = [self.description fieldWithIndexPath:indexPath];
    
    // get the reuses tableViewCell from the field with necessary data modifications
    UITableViewCell *cell = [field cellForTableView:tableView];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SMFormSection *formSection = [self.description.sections objectAtIndex:section];
    
    return [formSection.fields count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.description.sections count];
}

#pragma mark - table view delegate

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the field
    SMFormField *field = [self.description fieldWithIndexPath:indexPath];
    return [field height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMFormField *field = [self.description fieldWithIndexPath:indexPath];
    
    // if field has an action, execute it
    if ([field hasAction]) {
        
        if ([self.delegate respondsToSelector:@selector(formDidStartAction:)]) {
            [self.delegate formDidStartAction:self];
        }
        
        // field actions delegate the job to the `SMFormAction` objects
        [field executeActionWithDescription:self.description completion:^(NSError *error) {
            if (error) {
                if ([self.delegate respondsToSelector:@selector(formDidFail:)]) {
                    [self.delegate formDidFail:self];
                }
                return;
            }
            
            if ([self.delegate respondsToSelector:@selector(formDidSuccess:)]) {
                [self.delegate formDidSuccess:self];
            }
        }];
    }
}

@end
