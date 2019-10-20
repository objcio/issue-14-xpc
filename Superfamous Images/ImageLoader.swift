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
        self.imageDownloadConnection.invalidate()
    }
    
	func retrieveImageAtURL(url: URL, completionHandler: @escaping (NSImage?)->Void) {
        
        let untypedDownloader = self.imageDownloadConnection.remoteObjectProxyWithErrorHandler { error in
			print("remote proxy error: \(error)")
		}
		guard let downloader = untypedDownloader as? ImageDownloaderProtocol else {
			completionHandler(nil)
			return
		}

		downloader.downloadImageAtURL(url:url) {
			data in
			DispatchQueue.global(qos: .unspecified).async {
				guard
					let data = data,
					let source = CGImageSourceCreateWithData(data as CFData, nil),
					let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil)
				else { completionHandler(nil); return }

				let size = CGSize(width: cgImage.width, height: cgImage.height)
				let image = NSImage(cgImage: cgImage, size: size)
				completionHandler(image)
			}
		}
    }
}
