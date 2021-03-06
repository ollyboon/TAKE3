//
//  myLocation.swift
//  Folding
//
//  Created by Hallam John Ager on 18/05/2016.
//  Copyright © 2016 Hallam John Ager. All rights reserved.
//

import UIKit
import FoldingCell
import MapKit

protocol RouteCellDelegate {
    func buttonTapped(tag:Int)
}

class RouteCell: FoldingCell {
    
    var route: Route!
    var delegate: RouteCellDelegate?
    
    @IBOutlet weak var terrainTypeLable: UILabel!
    @IBOutlet weak var colorDiff: UIImageView!
    @IBOutlet weak var pathColor: UIView!
    @IBOutlet weak var mapRouteImage: UIImageView!
    @IBOutlet weak var terrainImage: UIImageView!
    @IBOutlet weak var pathImage: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var foldingNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextView!
    @IBOutlet weak var MapeImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
 //Defines sides, shadows and colour of the cells for the viewcontroller.
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 5
        foregroundView.layer.shadowOpacity = 1.7
        foregroundView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        foregroundView.layer.shadowRadius = 5.0
        foregroundView.layer.shadowColor = UIColor.lightGrayColor().CGColor
        
        backgroundColor = .clearColor()
        
        super.awakeFromNib()
    }
    
    @IBAction func showMap(sender: AnyObject) {
        delegate?.buttonTapped(goButton.tag)
    }
    //all info for cell is brought in here.
    func setUpCell() {
        infoTextField.userInteractionEnabled = false
        foldingNameLabel.text = route.foldingName
        nameLabel.text = route.name
        infoTextField.text = route.info
        durationLabel.text = route.duration
        infoLabel.text = route.terrainInfo
        pathImage.image = UIImage(named: route.name)
        terrainImage.image = UIImage(named: route.terrainImage)
        mapRouteImage.image = UIImage(named: route.mapRouteImage)
        pathColor.backgroundColor = route.color
        colorDiff.image = UIImage(named: route.colordiff)
        terrainTypeLable.text = route.terrainType
    }
    
    //Defines times for flipping animation.
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.20, 0.20, 0.20] // timing animation for each view
        return durations[itemIndex]
    }
    
    override func openAnimation(completion completion: CompletionHandler?) {
        super.openAnimation { 
            print("finsihed")
        }
    }
    
}
