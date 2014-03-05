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
#import "SMFormTextField.h"
#import "SMFormTextArea.h"

@interface SMFormTableViewStrategy()
- (void)commonInit;
- (void)keyboardWillShown:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)dismissKeyboard:(UITapGestureRecognizer *)sender;
- (void)sendActionFromField:(SMFormField *)field;
@end

@implementation SMFormTableViewStrategy
{
    // container scroll view
    UIScrollView *scrollView;
}
@synthesize description, action;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.description = [[SMFormDescription alloc] initWithDictionary:dictionary];
        self.description.delegate = self;
        [self commonInit];
    }
    return self;
}

- (id)initWithDescription:(SMFormDescription *)formDescription
{
    self = [super init];
    if (self) {
        self.description = formDescription;
        self.description.delegate = self;
        [self commonInit];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary scrollView:(UIScrollView *)containerScrollView
{
    self = [super init];
    if (self) {
        self.description = [[SMFormDescription alloc] initWithDictionary:dictionary];
        self.description.delegate = self;
        scrollView = containerScrollView;
        [self commonInit];
    }
    return self;
}

- (id)initWithDescription:(SMFormDescription *)formDescription scrollView:(UIScrollView *)containerScrollView
{
    self = [super init];
    if (self) {
        self.description = formDescription;
        self.description.delegate = self;
        scrollView = containerScrollView;
        [self commonInit];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private methods

- (void)commonInit
{
    // only add notification if we can use them
    if (!scrollView) return;
    
    // add keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    // tap recognizer to dismiss keyboard when tapping anywhere
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(dismissKeyboard:)];
    [tapGesture setCancelsTouchesInView:NO];
    [scrollView addGestureRecognizer:tapGesture];
}

- (void)keyboardWillShown:(NSNotification *)notification
{
    // return if we cannot make use of it
    if (!scrollView) return;
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // Scroll the target text field into view.
    // Get the main view
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = window.rootViewController.view;
    CGRect aRect = topView.frame;
    aRect.size.height -= keyboardSize.height;

    if (self.description.activeField && !CGRectContainsPoint(aRect, self.description.activeField.field.frame.origin) ) {
        for (UIView *subview in scrollView.subviews) {
            if ([subview isKindOfClass:[UITableView class]]) {
                // override the default scrolling functionality
                if ([self.delegate respondsToSelector:@selector(formShouldAdjustScrollOffset:)] &&
                    ![self.delegate formShouldAdjustScrollOffset:self]
                    )
                {
                    // scroll behavior is overridden by the delegate
                } else {
                    // default scroll behavior, adjust the offset where the active field should be on top of the screen.
                    float relative = subview.frame.origin.y + self.description.activeField.field.frame.origin.y;
                    CGPoint scrollPoint = CGPointMake(0.0, relative);
                    [scrollView setContentOffset:scrollPoint animated:YES];
                }
                
                break;
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(formDidStartEditing:)]) {
        [self.delegate formDidStartEditing:self];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    // return if we cannot make use of it
    if (!scrollView) return;
    
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:0.2 animations:nil];
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
    
    if ([self.delegate respondsToSelector:@selector(formDidEndEditing:)]) {
        [self.delegate formDidEndEditing:self];
    }
}

- (void)dismissKeyboard:(UITapGestureRecognizer *)sender
{
    if (sender.state != UIGestureRecognizerStateEnded) return;
    
    if ([self.description.activeField respondsToSelector:@selector(endEditing:)]) {
        [self.description.activeField endEditing:YES];
    }
}

- (void)sendActionFromField:(SMFormField *)field
{
    // field has an action, execute it
    if ([self.delegate respondsToSelector:@selector(form:didStartActionFromField:)]) {
        [self.delegate form:self didStartActionFromField:field];
    }
    
    // if field has no action, stop the execution
    if (![field hasAction]) {
        //NSLog(@"There is no registered action on the field, but it triggered the action via keyboard's SEND return type.");
        return;
    }
    
    // field actions delegate the job to the `SMFormAction` objects
    [field executeActionWithDescription:self.description completion:^(NSError *error) {
        if (error) {
            if ([self.delegate respondsToSelector:@selector(form:didFailFromField:)]) {
                [self.delegate form:self didFailFromField:field];
            }
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(form:didSuccesFromField:)]) {
            [self.delegate form:self didSuccesFromField:field];
        }
    }];
}

#pragma mark - table view data source

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
    
    [self sendActionFromField:field];
}

#pragma mark - description delegate

- (void)fieldDidDemandAction:(SMFormField *)field
{
    [self sendActionFromField:field];
}

@end
