//
//  SMFormModel.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/10/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormModel.h"
#import "SMFormDescription.h"
#import "SMApiClient.h"
#import "SMFormSection.h"
#import "SMFormField.h"

@implementation SMFormModel

+ (void)submitFormDescription:(SMFormDescription *)formDescription
                  toUrlString:(NSString *)urlString
                   completion:(void (^)(NSError *))completion
{
    [[SMApiClient sharedClient] postPath:urlString parameters:[formDescription formData] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(error);
        }
    }];
}

@end
