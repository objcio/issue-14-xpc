//
//  AppDelegate.swift
//  Superfamous Images
//
//  Created by Daniel Eggert on 21/06/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }
    @IBAction func showWebsite(_: AnyObject) {
        NSWorkspace.shared().open(URL(string: "http://superfamous.com")!)
    }
    
}
