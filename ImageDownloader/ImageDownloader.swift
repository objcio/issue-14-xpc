//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by Daniel Eggert on 22/06/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Foundation



class ImageDownloader : NSObject, ImageDownloaderProtocol {
	let session: URLSession
    
	override init()  {
		let config = URLSessionConfiguration.default
		session = URLSession(configuration: config)
    }
    
	func downloadImageAtURL(url: URL, withReply: @escaping (Data?)->Void) {
		let task = session.dataTask(with: url as URL) {
            data, response, error in
			if let httpResponse = response as? HTTPURLResponse {
                switch (data, httpResponse) {
                case let (d, r) where (200 <= r.statusCode) && (r.statusCode <= 399):
                    withReply(d)
                default:
                    withReply(nil)
                }
            }
        }
        task.resume()
    }
}
