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

	@IBAction func showWebsite(_: AnyObject) {
		NSWorkspace.shared.open(URL(string: "https://superfamous.com")!)
    }
    
}
