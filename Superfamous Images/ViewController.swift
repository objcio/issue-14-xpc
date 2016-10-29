//
//  ViewController.swift
//  Superfamous Images
//
//  Created by Daniel Eggert on 21/06/2014.
//  Copyright (c) 2014 objc.io. All rights reserved.
//

import Cocoa



class ViewController: NSViewController, ImageSetChangeObserver {
    
    @IBOutlet var tableView: NSTableView?
    var imageSet: ImageSet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageSet = ImageSet(changeObserver: self)
        imageSet?.startLoadingImages()
    }
    
    func imageSetDidChange(_ set: ImageSet) {
        tableView?.reloadData();
    }
}



extension ViewController : NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return imageSet?.images.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.make(withIdentifier: "Image", owner: self) as! NSTableCellView
        var image: NSImage?
        if let c = imageSet?.images.count, row < c {
            image = imageSet?.images[row]
        }
        cellView.imageView?.image = image
        return cellView
    }
}
