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
        connection.remoteObjectInterface = NSXPCInterface(with: ImageDownloaderProtocol.self)
        connection.resume()
        return connection
    }()

    deinit {
        imageDownloadConnection.invalidate()
    }

    func retrieveImage(url: URL, completionHandler: @escaping (NSImage?) -> Void) {

        let handler: (Error) -> () = { error in
            print("remote proxy error: \(error)")
        }

        let downloader = imageDownloadConnection.remoteObjectProxyWithErrorHandler(handler) as! ImageDownloaderProtocol

        downloader.downloadImageAtURL(url) { data in
            DispatchQueue.global().async {
                var image: NSImage?
                defer {
                    completionHandler(image)
                }
                guard let source = CGImageSourceCreateWithData(data as! CFData, nil),
                    let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
                        return
                }

                let size = CGSize(width: CGFloat(cgImage.width), height: CGFloat(cgImage.height))
                image = NSImage(cgImage: cgImage, size: size)
            }
        }
    }
}


