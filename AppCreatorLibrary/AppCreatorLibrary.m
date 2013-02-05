//
//  AppCreatorLibrary.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/4/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "AppCreatorLibrary.h"
#import <SSToolkit/SSToolkit.h>

@implementation AppCreatorLibrary

- (void)saySomething
{
    SSTextField *textField = [[SSTextField alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [textField setText:@"yeah"];
    NSLog(@"say somethonjg %@", textField.text);
}

@end
