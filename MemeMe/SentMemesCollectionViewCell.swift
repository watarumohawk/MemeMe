//
//  SentMemesCollectionViewCell.swift
//  MemeMe
//
//  Created by 関口渉 on 8/21/16.
//  Copyright © 2016 Wataru Sekiguchi. All rights reserved.
//

import UIKit

class SentMemesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
    }

}


