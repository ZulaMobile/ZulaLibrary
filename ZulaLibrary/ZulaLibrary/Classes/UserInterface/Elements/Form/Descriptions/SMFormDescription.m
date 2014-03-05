//
//  SMFormDescription.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormDescription.h"
#import "SMFormSection.h"
#import "SMFormField.h"
#import "SMFormFieldFactory.h"

@implementation SMFormDescription
@synthesize sections, extraData, delegate;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.extraData = [NSDictionary dictionary];
        
        NSArray *raw_sections = [dictionary objectForKey:@"sections"];
        if (![raw_sections isKindOfClass:[NSArray class]]) {
            DDLogError(@"Malformed form description, missing `sections`. Dictionary: %@", dictionary);
            // raise an exception?
            return self;
        }
        
        NSMutableArray *sectionsArr = [NSMutableArray arrayWithCapacity:[raw_sections count]];
        for (NSDictionary *raw_section in raw_sections) {
            SMFormSection *section = [[SMFormSection alloc] init];
            
            NSArray *raw_fields = [raw_section objectForKey:@"fields"];
            if ([raw_fields isKindOfClass:[NSArray class]]) {
                NSMutableArray *fieldsArr = [NSMutableArray arrayWithCapacity:[raw_fields count]];
                for (NSDictionary *raw_field in raw_fields) {
                    // create field instance
                    SMFormField *field = [SMFormFieldFactory createFieldWithDictionary:raw_field];
                    if (field) {
                        [field setDelegate:self];
                        [fieldsArr addObject:field];
                    }
                }
                [section setFields:[NSArray arrayWithArray:fieldsArr]];
            }
            
            [section setTitle:[raw_section objectForKey:@"title"]];
            [sectionsArr addObject:section];
        }
        [self setSections:[NSArray arrayWithArray:sectionsArr]];
    }
    return self;
}

- (id)initWithSections:(NSArray *)formSections
{
    self = [super init];
    if (self) {
        [self setSections:formSections];
        
        // set delegates
        for (SMFormSection *section in self.sections) {
            for (SMFormField *field in section.fields) {
                [field setDelegate:self];
            }
        }
    }
    return self;
}

- (SMFormField *)fieldWithIndexPath:(NSIndexPath *)indexPath
{
    SMFormSection *section = [self.sections objectAtIndex:[indexPath section]];
    return [section.fields objectAtIndex:[indexPath row]];
}

- (id)initWithJSONFile:(NSString *)file
{
    @throw [NSException exceptionWithName:@"Not Yet Implemented"
                                   reason:@"This class is not implemented yet"
                                 userInfo:nil];
}

- (id)initWithJSONString:(NSString *)json
{
    @throw [NSException exceptionWithName:@"Not Yet Implemented"
                                   reason:@"This class is not implemented yet"
                                 userInfo:nil];
}

- (id)initwithPlistFile:(NSString *)plistFile
{
    @throw [NSException exceptionWithName:@"Not Yet Implemented"
                                   reason:@"This class is not implemented yet"
                                 userInfo:nil];
}
- (NSDictionary *)formData
{
    // add any extra data to the form data
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:self.extraData];
    
    // add all the form field datas
    for (SMFormSection *section in self.sections) {
        for (SMFormField *field in section.fields) {
            if ([field isDataField]) {
                [data setObject:[field data] forKey:field.name];
            }
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:data];
}


#pragma mark - field delegate

- (void)fieldDidBecameActive:(SMFormField *)field
{
    [self setActiveField:field];
}

- (void)fieldDidBecameInactive:(SMFormField *)field
{
    [self setActiveField:nil];
}

- (BOOL)field:(SMFormField *)field shouldReturnWithReturnKeyType:(UIReturnKeyType)returnKeyType
{
    if (returnKeyType == UIReturnKeyNext) {
        // activate the next field
        for (SMFormSection *section in self.sections) {
            NSInteger fieldCount = [section.fields count];
            for (int i = 0; i < fieldCount; i++) {
                SMFormField *aField = [section.fields objectAtIndex:i];
                if (aField == field) {
                    if (i + 1 < fieldCount) {
                        SMFormField *nextField = [section.fields objectAtIndex:i+1];
                        if (nextField) {
                            [nextField.field becomeFirstResponder];
                            [self setActiveField:nextField];
                        }
                    }
                    break;
                }
            }
        }
        return NO;
    } else if (returnKeyType == UIReturnKeySend || returnKeyType == UIReturnKeyGo || returnKeyType == UIReturnKeyJoin) {
        if ([self.delegate respondsToSelector:@selector(fieldDidDemandAction:)]) {
            [self.delegate fieldDidDemandAction:field];
        }
    }
    
    // default behavior is to end the editing
    [field.field endEditing:YES];
    return YES;
}

@end
