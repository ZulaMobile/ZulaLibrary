//
//  SMListViewControllerTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//
#import "GHUnit.h"
#import "SMListViewController.h"
#import "SMComponentDescription.h"
#import "SMListPage.h"
#import "SMListItem.h"
#import "SMContentViewController.h"
#import "SMContentPage.h"

@interface SMListViewControllerTests : GHTestCase

@end

@implementation SMListViewControllerTests
{
    SMComponentDescription *_componentDescription;
    SMListPage *_listPage;
}

#warning fix this
/*
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
 @"bg_image": @"http://localhost:8000/media/cache/d0/0d/d00dac305398fcee38b48e24ccaca322.png",
 @"item_bg_image": @"http://localhost:8000/media/cache/6e/0c/6e0c55731aba01c848b1f28ddf9a63d9.png",
 @"listing_style": @"table",
 @"items": @[
 @{
 @"title": @"My news item 1",
 @"subtitle": @"my news subtitle 1",
 @"image": @"http://localhost:8000/media/cache/a5/f1/a5f1bf280fda111cccae3936b52392d4@2x.png",
 @"content": @"Lorem ipsum",
 @"target_component_url": @"",
 @"target_component_type": @"",
 @"thumbnail": @"http://localhost:8000/media/cache/76/06/760695076cef82337ae13114e38633ab.png"
 },
 @{
 @"title": @"My news item 2",
 @"subtitle": @"my news subtitle 2",
 @"image": @"",
 @"content": @"Lorem ipsum",
 @"target_component_url": @"http://somecomponent",
 @"target_component_type": @"ListComponent",
 @"thumbnail": @"http://localhost:8000/media/cache/76/06/760695076cef82337ae13114e38633ab.png"
 },
 @{
 @"title": @"My news item 3 My news item 3 My news item 3 My news item 3",
 @"subtitle": @"my news subtitle 3 my news subtitle 3 my news subtitle 3",
 @"image": @"", // no image
 @"content": @"", // no content
 @"target_component_url": @"",
 @"target_component_type": @"",
 @"thumbnail": @"http://localhost:8000/media/cache/76/06/760695076cef82337ae13114e38633ab.png"
 },
 @{
 @"title": @"My news item 4",
 @"subtitle": @"my news subtitle 4",
 @"image": @"",
 @"content": @"Lorem ipsum",
 @"target_component_url": @"",
 @"target_component_type": @"",
 @"thumbnail": @"http://localhost:8000/media/cache/76/06/760695076cef82337ae13114e38633ab.png"
 },
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
 #warning fix following test line
 //STAssertTrue([listItem.imageUrl.relativeString isEqualToString:contentPage.imageUrl.relativeString], @"content page model is invalid");
 STAssertTrue([_listPage.backgroundUrl.relativeString isEqualToString:contentPage.backgroundUrl.relativeString], @"content page model is invalid");
 }
 
 - (void)testTargetComponentNoComponent
 {
 SMListViewController *ctrl = [[SMListViewController alloc] initWithDescription:_componentDescription];
 [ctrl setListPage:_listPage];
 
 SMBaseComponentViewController *targetComponent = [ctrl targetComponentByListItem:[_listPage.items objectAtIndex:2]];
 STAssertNil(targetComponent, @"target component failed");
 }
 
 - (void)testTargetComponentCustomComponent
 {
 SMListViewController *ctrl = [[SMListViewController alloc] initWithDescription:_componentDescription];
 [ctrl setListPage:_listPage];
 
 SMBaseComponentViewController *targetComponent = [ctrl targetComponentByListItem:[_listPage.items objectAtIndex:1]];
 STAssertTrue([targetComponent isKindOfClass:[SMContentViewController class]], @"content component creation failed");
 STAssertTrue([targetComponent.title isEqualToString:@"My news item 2"], @"target component title is incorrect");
 }
 */
@end
