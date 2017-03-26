//
//  EventCell.swift
//  Snap Stream
//
//  Created by Steven DiCarlo on 3/25/17.
//  Copyright © 2017 Steven DiCarlo. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
	
	
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var thumb: UIImageView!
	
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}

