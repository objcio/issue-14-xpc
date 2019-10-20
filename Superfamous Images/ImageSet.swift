//
//  ImageSet.swift
//  Superfamous Images
//
//  Created by Daniel Eggert on 21/06/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Cocoa



@objc protocol ImageSetChangeObserver {
    func imageSetDidChange(set: ImageSet) -> Void
}



class ImageSet : NSObject {
    
    weak var changeObserver: ImageSetChangeObserver! = nil
    var images: [NSImage?] = [] {
        didSet {
			self.changeObserver.imageSetDidChange(set: self)
        }
    }
    let imageLoader = ImageLoader()
    
    init(changeObserver observer: ImageSetChangeObserver) {
        changeObserver = observer
    }
    
    func startLoadingImages() {
        for urlString in self.imageURLs {
			if let url = URL(string: urlString) {
				self.imageLoader.retrieveImageAtURL(url: url) {
					image in
					DispatchQueue.main.async {
						var i = self.images
						i.append(image)
						self.images = i
					}
				}
			}
        }
    }
    
    // https://superfamous.com
    // Photographs are available under a CC Attribution 3.0 license.
    let imageURLs: [String] = [
        "https://payload203.cargocollective.com/1/8/282864/6367350/DSC_0058_900.JPG",
        "https://payload175.cargocollective.com/1/8/282864/5815632/9042399407_bf04388aca_o_900.jpg",
        "https://payload88.cargocollective.com/1/8/282864/4071568/DSC_0817_900.jpg",
        "https://payload175.cargocollective.com/1/8/282864/5804803/DSC_0294_900.jpg",
        "https://payload175.cargocollective.com/1/8/282864/5815628/DSC_0631_1_900.jpg",
        "https://payload93.cargocollective.com/1/8/282864/4164574/DSC_0476%20copycrop_900.jpg",
        "https://payload116.cargocollective.com/1/8/282864/4631161/DSC_0624_900.jpg",
    ]
    
}
