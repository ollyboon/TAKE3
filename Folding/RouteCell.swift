

import UIKit
import FoldingCell
import MapKit

protocol RouteCellDelegate {
    func buttonTapped(tag:Int)
}

class RouteCell: FoldingCell {
    
    var route: Route!
    var delegate: RouteCellDelegate?
    
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
    }
    
    
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
