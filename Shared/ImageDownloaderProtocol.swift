//
//  ImageDownloaderProtocol.swift
//  Superfamous Images
//
//  Created by Daniel Eggert on 08/07/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Foundation



@objc(ImageDownloaderProtocol)
protocol ImageDownloaderProtocol {
    func downloadImageAtURL(url: URL, withReply: @escaping (Data?)->Void)
}
