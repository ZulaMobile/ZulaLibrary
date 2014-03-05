//
//  SMListPage.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListPage.h"
#import "ZulaLibrary.h"
#import "SMListItem.h"
#import "SMApiClient.h"

@implementation SMListPage
@synthesize title = _title,
backgroundUrl = _backgroundUrl,
itemBackgroundUrl = _itemBackgroundUrl,
listingStyle = _listingStyle,
items = _items,
images = _images,
navbarIcon = _navbarIcon;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        [self setTitle:[attributes objectForKey:kModelListPageTitle]];
        
        _backgroundUrl = [self urlFromAttribute:[attributes objectForKey:kModelListPageBackgroundImageUrl]];
        _itemBackgroundUrl = [self urlFromAttribute:[attributes objectForKey:kModelListPageItemBackgroundImageUrl]];
        
        // default listing style is table
        NSString *theListingStyle = [attributes objectForKey:kModelListPageListType];
        if (!theListingStyle || [theListingStyle isEqualToString:@"table"]) {
            _listingStyle = SMListingStyleTable;
        } else if ([theListingStyle isEqualToString:@"box"]) {
            _listingStyle = SMListingStyleBox;
        } else if ([theListingStyle isEqualToString:@"group"]) {
            _listingStyle = SMListingStyleGroup;
        } else if ([theListingStyle isEqualToString:@"summary"]) {
            _listingStyle = SMListingStyleSummary;
        }
        
        NSArray *theItems = (NSArray *)[attributes objectForKey:kModelListPageItems];
        
        // items are initially an empty array
        if ([theItems count] == 0) {
            _items = [NSArray array];
        } else {
            NSMutableArray *itemsArr = [NSMutableArray arrayWithCapacity:[theItems count]];
            for (NSDictionary *itemDict in theItems) {
                SMListItem *item = [[SMListItem alloc] initWithAttributes:itemDict];
                [itemsArr addObject:item];
            }
            _items = [NSArray arrayWithArray:itemsArr];
        }
        
        // images
        if ([[attributes objectForKey:kModelListPageImages] isKindOfClass:[NSArray class]]) {
            NSArray *imagesFetched = [attributes objectForKey:kModelListPageImages];
            NSMutableArray *imagesArr = [NSMutableArray arrayWithCapacity:[imagesFetched count]];
            for (NSString *imageUrl in imagesFetched) {
                [imagesArr addObject:[NSURL URLWithString:imageUrl]];
            }
            _images = [NSArray arrayWithArray:imagesArr];
        }
        
        // navbar icon
        NSString *navbarIconUrlString = [attributes objectForKey:kModelListNavbarIcon];
        if (navbarIconUrlString && ![navbarIconUrlString isEqualToString:@""]) {
            _navbarIcon = [NSURL URLWithString:navbarIconUrlString];
        }
    }
    return self;
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    return ([response objectForKey:kModelListPageTitle] &&
            [response objectForKey:kModelListPageBackgroundImageUrl] &&
            [response objectForKey:kModelListPageItemBackgroundImageUrl] &&
            [response objectForKey:kModelListPageListType] &&
            [response objectForKey:kModelListPageImages] &&
            [response objectForKey:kModelListPageItems]);
}

+ (void)fetchWithUrlString:(NSString *)urlString completion:(void (^)(SMListPage *, NSError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // validate response
        if (![SMListPage isValidResponse:responseObject]) {
            SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
            if (completion) {
                completion(nil, err);
            }
            return;
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        SMListPage *page = [[SMListPage alloc] initWithAttributes:response];
        if (completion) {
            completion(page, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure
        SMServerError *err = [[SMServerError alloc] initWithOperation:operation];
        if (completion) {
            completion(nil, err);
        }
    }];
}

@end
