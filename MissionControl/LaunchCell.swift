//
//  LaunchCell.swift
//  MissionControl
//
//  Created by Daniel Cizmarik on 4/28/19.
//  Copyright © 2019 Daniel Cizmarik. All rights reserved.
//

import UIKit

class LaunchCell: UITableViewCell {

    
    @IBOutlet weak var cellLaunchName: UILabel!
    
    @IBOutlet weak var cellLaunchLocation: UILabel!
    
    @IBOutlet weak var cellLaunchDate: UILabel!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func update(with launch: Launch) {
        cellLaunchName.text = Launch.launchName
        cellLaunchLocation.text = Launch.launchPadName
        cellLaunchDate.text = String(Launch.launchDate)
        
        
    }

}
