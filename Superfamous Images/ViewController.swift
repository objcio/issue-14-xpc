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
        self.imageSet = ImageSet(changeObserver: self)
        self.imageSet?.startLoadingImages()
    }
    
    func imageSetDidChange(set: ImageSet) {
        self.tableView?.reloadData();
    }
}



extension ViewController : NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        if let c = self.imageSet?.images.count {
            return c
        } else {
            return 0
        }
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 400
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeViewWithIdentifier("Image", owner: self) as! NSTableCellView
        var image: NSImage? = nil
        if let c = self.imageSet?.images.count {
            if row < c {
                image = self.imageSet?.images[row]
            }
        }
        cellView.imageView!.image = image
        return cellView
    }
}
