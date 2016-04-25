//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by Daniel Eggert on 22/06/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Foundation



class ImageDownloader : NSObject, ImageDownloaderProtocol {
    let session: NSURLSession
    
    override init()  {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config)
    }
    
    func downloadImageAtURL(url: NSURL!, withReply: ((NSData!)->Void)!) {
        let task = session.dataTaskWithURL(url) {
            data, response, error in
            if let httpResponse = response as? NSHTTPURLResponse {
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
