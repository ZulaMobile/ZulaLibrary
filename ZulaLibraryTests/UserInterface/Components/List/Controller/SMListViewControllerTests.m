//
//  SMListViewControllerTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMListViewControllerTests.h"
#import "SMListViewController.h"
#import "SMComponentDescription.h"
#import "SMListPage.h"
#import "SMListItem.h"
#import "SMContentViewController.h"
#import "SMContentPage.h"

@implementation SMListViewControllerTests
{
    SMComponentDescription *_componentDescription;
    SMListPage *_listPage;
}

- (void)setUp
{
    _componentDescription = [[SMComponentDescription alloc] initWithAttributes:
                             @{
                             @"type": @"list",
                             @"title": @"My News",
                             @"slug": @"my-news",
                             @"url": @""
                             }];
    
    _listPage = [[SMListPage alloc] initWithAttributes:
                 @{
                 @"title": @"My Cool List",
                 @"bg_image": @"http://example.com/bg_image.png",
                 @"item_bg_image": @"http://example.com/item_bg_image.png",
                 @"listing_style": @"table",
                 @"items": @[
                 @{@"title": @"My news item 1", @"subtitle": @"my news subtitle 1", @"image": @"http://example.com/item1.png", @"content": @"Lorem ipsum", @"target_component_url": @"", @"target_component_type": @""},
                 @{@"title": @"My news item 2", @"subtitle": @"my news subtitle 2", @"image": @"http://example.com/item2.png", @"content": @"Lorem ipsum", @"target_component_url": @"http://localhost:8000/somecomponent/", @"target_component_type": @"HomePage"},
                 @{@"title": @"My news item 3", @"subtitle": @"my news subtitle 3", @"image": @"http://example.com/item3.png", @"content": @"Lorem ipsum", @"target_component_url": @"", @"target_component_type": @""},
                 @{@"title": @"My news item 4", @"subtitle": @"my news subtitle 4", @"image": @"http://example.com/item4.png", @"content": @"Lorem ipsum", @"target_component_url": @"", @"target_component_type": @""},
                 ]
                 }];
}

- (void)testCreationOfComponent
{
    SMListViewController *ctrl = [[SMListViewController alloc] initWithDescription:_componentDescription];
    [ctrl setListPage:_listPage];
    
    STAssertTrue([ctrl.title isEqualToString:@"My News"], @"title is failed");
}

- (void)testTargetComponentCreationContentComponent
{
    SMListViewController *ctrl = [[SMListViewController alloc] initWithDescription:_componentDescription];
    [ctrl setListPage:_listPage];
    
    // creates content component
    SMBaseComponentViewController *targetComponent = [ctrl targetComponentByListItem:[_listPage.items objectAtIndex:0]];
    STAssertTrue([targetComponent isKindOfClass:[SMContentViewController class]], @"content component creation failed");
    STAssertTrue([targetComponent.title isEqualToString:@"My news item 1"], @"target component title is incorrect");

    SMListItem *listItem = [_listPage.items objectAtIndex:0];
    SMContentPage *contentPage = [(SMContentViewController *)targetComponent contentPage];
    STAssertTrue([listItem.title isEqualToString:contentPage.title], @"content page model is invalid");
    STAssertTrue([listItem.content isEqualToString:contentPage.text], @"content page model is invalid");
    STAssertTrue([listItem.imageUrl.relativeString isEqualToString:contentPage.imageUrl.relativeString], @"content page model is invalid");
    STAssertTrue([_listPage.backgroundUrl.relativeString isEqualToString:contentPage.backgroundUrl.relativeString], @"content page model is invalid");
}

- (void)testTargetComponentCustomComponent
{
    SMListViewController *ctrl = [[SMListViewController alloc] initWithDescription:_componentDescription];
    [ctrl setListPage:_listPage];
    
    SMBaseComponentViewController *targetComponent = [ctrl targetComponentByListItem:[_listPage.items objectAtIndex:0]];
    STAssertTrue([targetComponent isKindOfClass:[SMContentViewController class]], @"content component creation failed");
    STAssertTrue([targetComponent.title isEqualToString:@"My news item 1"], @"target component title is incorrect");
    
    
}

@end
