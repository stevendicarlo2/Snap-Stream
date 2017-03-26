//
//  CameraViewController.swift
//  Snap Stream
//
//  Created by Steven DiCarlo on 3/26/17.
//  Copyright © 2017 Steven DiCarlo. All rights reserved.
//

import UIKit

class CameraViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	
	let imagePicker = UIImagePickerController()

	override func viewDidLoad() {
		super.viewDidLoad()
		imagePicker.delegate = self
		
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	
	
	
	
	
}
