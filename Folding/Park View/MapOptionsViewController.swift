import UIKit

enum MapOptionsType: Int {
  case MapOverlay = 0
  case MapPins
  case MapRoute
}

class MapOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var selectedOptions = [MapOptionsType]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("OptionCell") as UITableViewCell!
    let mapOptionsType = MapOptionsType(rawValue: indexPath.row)
    switch (mapOptionsType!) {
    case .MapOverlay:
      cell.textLabel!.text = "Map Overlay"
    case .MapPins:
      cell.textLabel!.text = "Pins"
    case .MapRoute:
      cell.textLabel!.text = "Route"
    }
    
    if selectedOptions.contains(mapOptionsType!) {
      cell.accessoryType = UITableViewCellAccessoryType.Checkmark
    } else {
      cell.accessoryType = UITableViewCellAccessoryType.None
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    let mapOptionsType = MapOptionsType(rawValue: indexPath.row)
    if (cell!.accessoryType == UITableViewCellAccessoryType.Checkmark) {
      cell!.accessoryType = UITableViewCellAccessoryType.None
      selectedOptions = selectedOptions.filter { (currentOption) in currentOption != mapOptionsType}
    } else {
      cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
      selectedOptions += [mapOptionsType!]
    }
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}
