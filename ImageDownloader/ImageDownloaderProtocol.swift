//
//  ImageDownloaderProtocol.swift
//  ImageDownloader
//
//  Created by Daniel Eggert on 22/06/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Foundation


// This is the API that the service is vending.
// This file needs to be in both targets: In the service target and the main executable (the app)
@objc(ImageDownloaderProtocol) protocol ImageDownloaderProtocol {
    func downloadImage(atURL: NSURL!, withReply: (NSData?)->Void)
}
