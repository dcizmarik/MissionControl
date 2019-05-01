//
//  LaunchTableViewCell.swift
//  MissionControl
//
//  Created by Daniel Cizmarik on 4/28/19.
//  Copyright © 2019 Daniel Cizmarik. All rights reserved.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLaunchName: UILabel!
    @IBOutlet weak var cellLaunchLocation: UILabel!
    @IBOutlet weak var cellLaunchDate: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func update(with launch: Launch) {
        cellLaunchName.text = launch.launchName
        cellLaunchLocation.text = launch.launchShortLocation
        cellLaunchDate.text = launch.launchDate.prefix(3) + " '19"
    }
    
  
    
    
    

}
