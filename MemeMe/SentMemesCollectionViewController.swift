//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by 関口渉 on 8/17/16.
//  Copyright © 2016 Wataru Sekiguchi. All rights reserved.
//

import UIKit
import Foundation

class SentMemesCollectionViewController: UICollectionViewController {

    var memes: [Meme]!

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {

        
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.hidden = false
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemesCollectionViewCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
        let meme = memes[indexPath.item]
    
//        cell.setText(meme.top, bottomString: meme.bottom)
        
        let imageView = UIImageView(image: meme.memedImage)
        cell.backgroundView = imageView
        return cell
    }
    
}

