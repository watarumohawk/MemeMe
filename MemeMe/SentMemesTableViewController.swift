//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by 関口渉 on 9/25/16.
//  Copyright © 2016 Wataru Sekiguchi. All rights reserved.
//

import UIKit
import Foundation

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]!
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//     
//        let object = UIApplication.sharedApplication().delegate
//        let appDelegate = object as! AppDelegate
//        memes = appDelegate.memes
//        
//        tableView!.reloadData()
//    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableViewCell")!
        let meme = self.memes[indexPath.row]
        
        
//        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        
        cell.imageView?.image = UIImage(image: memes.memedImage)
        
//        contentImage = UIImageView(image: meme.memedImage)
        
        return cell
    }
    
}


