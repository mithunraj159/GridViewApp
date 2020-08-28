//
//  ViewController.swift
//  GridViewApp
//
//  Created by Mithun Raj on 27/08/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var collectionView: NSCollectionView!
    var flowers = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let fileManager = FileManager.default
        let flowerDir = getFolderPath()
        
        guard let fileURLs = try? fileManager.contentsOfDirectory(at: flowerDir, includingPropertiesForKeys: nil) else { return }
        
        print(fileURLs)
        
        for file in fileURLs {
            if file.pathExtension == "jpeg" {
                flowers.append(file)
            }
        }
        
        print("flowers", flowers)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func getFolderPath() -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentDir = urls[0]
        
        let flowerDir = documentDir.appendingPathComponent("Flowers")
        
        if !fileManager.fileExists(atPath: flowerDir.path) {
           try? fileManager.createDirectory(at: flowerDir, withIntermediateDirectories: true, attributes: nil)
        }
        
        return flowerDir
    }
    
}

extension ViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return flowers.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let collectionItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("Flowers"), for: indexPath) as! Flowers
        let imageUrl = flowers[indexPath.item]        
        let flowerImage = NSImage(contentsOf: imageUrl)
        collectionItem.imageView?.image = flowerImage
        collectionItem.view.wantsLayer = true
        collectionItem.view.layer?.backgroundColor = NSColor.black.cgColor
        return collectionItem
    }
    
    
}

