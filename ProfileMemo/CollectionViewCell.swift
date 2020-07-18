//
//  CollectionViewCell.swift
//  ProfileMemo
//
//  Created by 周依琳 on 2020/06/13.
//  Copyright © 2020 Yilin. All rights reserved.
//

import UIKit
import Gemini

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        nameLabel.isEnabled = false
////        // cellの枠の太さ
////        self.layer.borderWidth = 1.0
////        // cellの枠の色
////        self.layer.borderColor = UIColor.black.cgColor
//        // cellを丸くする
//        //self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2.0
//    }
}
