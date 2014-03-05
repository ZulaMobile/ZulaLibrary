//
//  SMFormTextField.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormField.h"

/**
 The type identifier
 */
#define kFormTextFieldType @"text"

@interface SMFormTextField : SMFormField <UITextFieldDelegate>

/**
 Set if you want to display a label view.
 Default is 0, that is no label, use placeholder text.
 */
@property (nonatomic) float labelWidth;

@end
