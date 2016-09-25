//
//  SentMemesTableViewCellController.swift
//  MemeMe
//
//  Created by 関口渉 on 9/25/16.
//  Copyright © 2016 Wataru Sekiguchi. All rights reserved.
//

import UIKit
import Foundation

class SentMemesTableViewCellController: UITableViewController {
    
    var memes: [Meme]!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableViewCell", forIndexPath: indexPath) as! SentMemesTableViewCell
        
        let meme = memes[indexPath.row]
        cell.textLabelCell.text = meme.topText + " " + meme.bottomText
        cell.tableImage.image = meme.image
        
        return cell
    }
    
}


