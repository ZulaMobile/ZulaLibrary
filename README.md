==================
iOS Project README
==================

AppCreator Library
==================

This is a "Cocoa Static Library" in the workspace. I have read the following article before I created this project

    http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/
    http://developer.apple.com/library/ios/#technotes/iOSStaticLibraries/Articles/creating.html

Installation
============

Requirement management is done using `CocoaPods`. See `PodFile` for dependency list.

To install requirements, issue the following command:

    pod install

To add a new dependency, search its availablitiy with `pod search`, then simply add it using the same format in the `PodFile` 

Creating a new App Type (As Sub Project on Workspace)
=====================================================

  * Create the sub project
  * Edit the scheme 
    * click manage schemes
    * Select the project scheme
    * Add `ZulaLibrary` as the 1st item on `build` section.
    * Add `ZulaLibraryTests` just before the testing entry.
  * On `Build Phases`
    * Add `libZulaLibrary.a`

Creating a New Project Based on ZulaLibrary
===========================================

  * Create a new xcode project, choose `Empty Application`
  * Create a `Podfile` with following:
        platform :ios, '6.0'
        pod 'ZulaLibrary', :path => "/Users/solomon/Projects/ZulaMobile/src/ios/ZulaLibrary/ZulaLibrary.podspec"
        pod 'AFNetworking', '~> 1.3.2'
        pod 'SVProgressHUD'
        pod 'MWPhotoBrowser', :git => 'https://github.com/yakubbaev/MWPhotoBrowser.git'
        pod 'SDSegmentedControl'
        pod 'MSPullToRefreshController'
        pod 'UIActivityIndicator-for-SDWebImage'
        pod 'SDWebImage-ProgressView'
        pod 'SWRevealViewController'
        pod 'SSToolkit'
    * Hit `pod install`
    * Edit prefix file (.pch file) and add following:
        #import <SystemConfiguration/SystemConfiguration.h>
        #import <MobileCoreServices/MobileCoreServices.h>
        #import "SMServerError.h"
        #import "ZulaLibrary.h"
        #import <DDLog.h>
        //#define DEBUG_APP 1
        #import "SMNotifications.h"
        #ifdef DEBUG
          static const int ddLogLevel = LOG_LEVEL_VERBOSE;
        #else
          static const int ddLogLevel = LOG_LEVEL_WARN;
        #endif
        #define ZULA_DEBUG 1
    * Edit main plist file and add following:
        `api_url`: `http://zula-api-url.com`
        `default_api_url`: `http://zula-default-api-url.com`
    * Edit `AppDelegate` and inherit from one of the AppDelegate classes (e.g. SMDefaultAppDelegate).
    * Edit `Pods-ZulaLibrary-Prefix.pch` file and add following:
        #import "ZulaLibrary.h"
        #import "DDLog.h"
        #ifdef DEBUG
          static const int ddLogLevel = LOG_LEVEL_VERBOSE;
        #else
          static const int ddLogLevel = LOG_LEVEL_WARN;
        #endif
    * Optionally create `app.plist` file and add following:
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>available_components</key>
          <array/>
        </dict>
        </plist>

Configuration Files
===================

Zula can work either a `plist` configuration file or a RESTFul web service (`json` endpoints).

Working With API endpoints
--------------------------

Add following entries to your main plist file:

    api_url: http://yourserver.com/api/

`api_url` is where all configuration of your app comes from. Following is an example app configuration:

    {
        "app-description": "http://lotb.zulamobile.com/api/v1/meta/app-description/", 
        "homepage": "http://lotb.zulamobile.com/api/v1/homepage/", 
        "content-containers": "http://lotb.zulamobile.com/api/v1/content-containers/", 
        "contents": "http://lotb.zulamobile.com/api/v1/contents/", 
        "lists": "http://lotb.zulamobile.com/api/v1/lists/"
    }

See docs for details.


Example Plist Configuration File
--------------------------------

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    <key>available_components</key>
    <array/>
    </dict>
    </plist>



Compilation 
===========

Build Options
-------------

Other linker flags: `-all_load` `-ObjC` `$(inherited)`
Always Search User Paths: No
