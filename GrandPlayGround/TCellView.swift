//
//  TCellView.swift
//  GrandPlayGround
//
//  Created by Hossam on 7/16/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class TCellView : UITableViewCell{
    @IBOutlet weak var imageViewDAta: UIImageView!
    @IBOutlet weak var tableText: UILabel!
    let gradiantLayer = CAGradientLayer()
    override func layoutSubviews() {
        super.layoutSubviews()
       gradiantLayer.frame = self.frame
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageViewDAta.image = nil
     
        self.textLabel?.text = nil
    }

    
}
