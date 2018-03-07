//
//  CategoryRow.swift
//  TwoDirectionalScroller
//
//  Created by Robert Chen on 7/11/15.
//  Copyright (c) 2015 Thorn Technologies. All rights reserved.
//

import UIKit
import Device

class tableViewRow : UITableViewCell {
    var arrayAnimals : [Animals] = []
    
    @IBOutlet weak var shadowView: UIView!
    
    
    @IBOutlet weak var mainTextLabel: UILabel!
    
    @IBOutlet weak var secondaryTextLabel: UILabel!
    

    @IBOutlet weak var imageToShow: GradientImageView!
    
}

