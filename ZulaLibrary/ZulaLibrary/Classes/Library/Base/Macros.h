//
//  Macros.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 09/09/14.
//  Copyright (c) 2014 ZulaMobile. All rights reserved.
//

#ifndef ZulaLibrary_Macros_h
#define ZulaLibrary_Macros_h

#define UIViewAutoresizingFlexibleAll                       \
UIViewAutoresizingFlexibleBottomMargin    | \
UIViewAutoresizingFlexibleHeight          | \
UIViewAutoresizingFlexibleLeftMargin      | \
UIViewAutoresizingFlexibleRightMargin     | \
UIViewAutoresizingFlexibleTopMargin       | \
UIViewAutoresizingFlexibleWidth

#define UIViewAutoresizingFlexibleMargins                   \
UIViewAutoresizingFlexibleBottomMargin    | \
UIViewAutoresizingFlexibleLeftMargin      | \
UIViewAutoresizingFlexibleRightMargin     | \
UIViewAutoresizingFlexibleTopMargin

#define UIViewAutoresizingDefault UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin

// iphone 5 detector
#define IS_IPHONE_5 ([UIScreen mainScreen].bounds.size.height == 568.0)

// iOS version detector
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// orientation detector
#define isLandscape() \
([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight)
#define isPortrait() \
([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)

// iPad/iPhone detector
#define isPad() \
([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && \
[[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)

// retina screen detector
#define isRetina() \
([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)

#endif
