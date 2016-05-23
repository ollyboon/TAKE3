//
//  ViewController.swift
//  Folding
//
//  Created by Kyle Goslan on 10/05/2016.
//  Copyright © 2016 Kyle Goslan. All rights reserved.
//

import UIKit
import FoldingCell


class ViewController: UIViewController {
    
    var cellBeenOpened = false
    var overlay: UIImageView?
    var selectedRow = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    let kCloseCellHeight: CGFloat = 160
    let kOpenCellHeight: CGFloat = 470
    
    var routes = buildRoutes()
    var routesName: String!
    var route: Route!
    
    var cellHeights = [CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        for _ in 0...routes.count {
            cellHeights.append(kCloseCellHeight)
        }
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg"))
        
                
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ParkMapViewController" {
            let vc = segue.destinationViewController as! ParkMapViewController
            vc.route = routes[selectedRow]
        }
        
    }
    

    @IBAction func showHelp(sender: AnyObject) {
        if overlay == nil {
            overlay = UIImageView(frame: tableView.frame)
            overlay!.image = UIImage(named: "cell image overlay")
            overlay?.userInteractionEnabled = true
            self.tabBarController!.view.addSubview(overlay!)
            self.tabBarController!.tabBar.alpha = 0
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: true)
            if cellBeenOpened {
                overlay!.image = UIImage(named: "fold image overlay")
                tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: true)
            }
            

            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped))
            overlay!.addGestureRecognizer(tap)
        }
    }

    func imageTapped() {
        if let overlay = overlay {
            overlay.removeFromSuperview()
            self.tabBarController!.tabBar.alpha = 1
        }
        overlay = nil
    }

}

extension ViewController: RouteCellDelegate {
    func buttonTapped(tag: Int) {
        selectedRow = tag
        performSegueWithIdentifier("ParkMapViewController", sender: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath) as! RouteCell
        
        cell.route = routes[indexPath.row]
        cell.setUpCell()
        cell.delegate = self
        cell.goButton.tag = indexPath.row
        
        return cell
    }
}

extension ViewController: UITabBarDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! RouteCell
        cellBeenOpened = true
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is RouteCell {
            let foldingCell = cell as! RouteCell
            cellBeenOpened = false
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
}

