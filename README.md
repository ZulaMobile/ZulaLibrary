==================
iOS Project README
==================

AppCreator Library
==================

ZulaLibrary is the core library of ZulaMobile. It includes the infrastructure to create applications. Please refer to wiki for details.

Installation
============

Requirement management is done using `CocoaPods`. See `PodFile` for dependency list.

To install requirements, issue the following command:

    pod install

To add a new dependency, search its availablitiy with `pod search`, then simply add it using the same format in the `PodFile` 

Creating a New Project Based on ZulaLibrary
===========================================

  * Create a new xcode project, choose `Empty Application`
  * Create a `Podfile` with following:

        platform :ios, '7.0'
        pod 'ZulaLibrary', :git => 'https://github.com/ZulaMobile/ZulaLibrary.git'
        pod 'AFNetworking', '~> 1.3.4'
        pod 'SVProgressHUD', '~> 1.0'
        pod 'SDSegmentedControl', '~> 1.0.2'
        pod 'MSPullToRefreshController', :git => 'https://github.com/laplacesdemon/MSPullToRefreshController.git'
        pod 'UIActivityIndicator-for-SDWebImage'
        pod 'SWRevealViewController', '~> 1.1.3'

  * Hit `pod install`
  * Edit prefix file (.pch file) and add following:

        #import <SystemConfiguration/SystemConfiguration.h>
        #import <MobileCoreServices/MobileCoreServices.h>
        #import "ZulaLibrary.h"

  * To use a RESTFul Api endpoint, Edit main plist file and add following:

        `api_url`: `http://zula-api-url.com`
        `default_api_url`: `http://zula-default-api-url.com`

  * Edit `AppDelegate` and inherit from one of the AppDelegate classes (e.g. SMDefaultAppDelegate).
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
