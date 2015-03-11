//
//  ImageLoader.swift
//  Superfamous Images
//
//  Created by Daniel Eggert on 21/06/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Cocoa
import ApplicationServices



class ImageLoader: NSObject {
    
    // An XPC service
    lazy var imageDownloadConnection: NSXPCConnection = {
        let connection = NSXPCConnection(serviceName: "io.objc.Superfamous-Images.ImageDownloader")
        connection.remoteObjectInterface = NSXPCInterface(withProtocol: ImageDownloaderProtocol.self)
        connection.resume()
        return connection
    }()
    
    deinit {
        self.imageDownloadConnection.invalidate()
    }
    
    func retrieveImageAtURL(url: NSURL, completionHandler: (NSImage?)->Void) {
        
        let downloader = self.imageDownloadConnection.remoteObjectProxyWithErrorHandler {
            	(error) in NSLog("remote proxy error: %@", error)
            } as! ImageDownloaderProtocol
        downloader.downloadImageAtURL(url) {
            data in
            dispatch_async(dispatch_get_global_queue(0, 0)) {
                let source = CGImageSourceCreateWithData(data, nil)
                let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil)
                var size = CGSize(
                    width: CGFloat(CGImageGetWidth(cgImage)),
                    height: CGFloat(CGImageGetHeight(cgImage)))
                let image = NSImage(CGImage: cgImage, size: size)
                completionHandler(image)
            }
        }
    }
}
