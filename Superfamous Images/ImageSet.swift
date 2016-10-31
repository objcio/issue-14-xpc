//
//  ImageSet.swift
//  Superfamous Images
//
//  Created by Daniel Eggert on 21/06/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Cocoa



@objc protocol ImageSetChangeObserver {
    func imageSetDidChange(_ set: ImageSet) -> Void
}



class ImageSet : NSObject {
    
    weak var changeObserver: ImageSetChangeObserver?
    var images: [NSImage?] = [] {
        didSet {
            changeObserver?.imageSetDidChange(self)
        }
    }

    let imageLoader = ImageLoader()
    
    init(changeObserver observer: ImageSetChangeObserver) {
        changeObserver = observer
    }
    
    func startLoadingImages() {
        let urls = imageURLs.flatMap { URL(string: $0) }
        for url in urls {
            imageLoader.retrieveImage(url: url) { image in
                DispatchQueue.main.async {
                    self.images.append(image)
                }
            }
        }
    }
    
    // http://superfamous.com
    // Photographs are available under a CC Attribution 3.0 license.
    let imageURLs = [
        "http://payload203.cargocollective.com/1/8/282864/6367350/DSC_0058_900.JPG",
        "http://payload175.cargocollective.com/1/8/282864/5815632/9042399407_bf04388aca_o_900.jpg",
        "http://payload88.cargocollective.com/1/8/282864/4071568/DSC_0817_900.jpg",
        "http://payload175.cargocollective.com/1/8/282864/5804803/DSC_0294_900.jpg",
        "http://payload175.cargocollective.com/1/8/282864/5815628/DSC_0631_1_900.jpg",
        "http://payload93.cargocollective.com/1/8/282864/4164574/DSC_0476%20copycrop_900.jpg",
        "http://payload116.cargocollective.com/1/8/282864/4631161/DSC_0624_900.jpg",
    ]
    
}
