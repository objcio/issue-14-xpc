//
//  ImageDownloaderMain.swift
//  ImageDownloader
//
//  Created by Daniel Eggert on 22/06/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Foundation

class ServiceDelegate : NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: ImageDownloaderProtocol.self)
        let exportedObject = ImageDownloader()
        newConnection.exportedObject = exportedObject
        newConnection.resume()
        return true
    }
}


// Create the listener and resume it:
let delegate = ServiceDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate;
listener.resume()
