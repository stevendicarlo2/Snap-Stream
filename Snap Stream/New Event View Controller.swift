//
//  New Event View Controller.swift
//  Snap Stream
//
//  Created by Steven DiCarlo on 3/25/17.
//  Copyright © 2017 Steven DiCarlo. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class NewEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	
	var locManager = CLLocationManager();
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	@IBOutlet weak var cancelButton: UIBarButtonItem!
	let imagePicker = UIImagePickerController()
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var uploadButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imagePicker.delegate = self
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	
	
	@IBAction func doneButtonPressed(_ sender: Any) {
		var title = nameField.text
		var newTitle: String = ""
		if title == nil{
			title = ""
		}else{
			newTitle = "\(title!)"
		}
		
		var currentLocation = CLLocation()
		if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ){
			currentLocation = locManager.location!
		}
		
		let latitude = "\(currentLocation.coordinate.latitude)"
		let longitude = "\(currentLocation.coordinate.longitude)"
		
		print(latitude, longitude)
		let url = "http://34.206.97.137/createevent?name=\(newTitle)&lat=\(latitude)&lon=\(longitude)"
		let goodURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
		
		Alamofire.upload(
			multipartFormData: { multipartFormData in
				multipartFormData.append(UIImageJPEGRepresentation(self.image.image!, 1)!, withName: "file", fileName: "picture.jpg", mimeType: "image/jpeg")
				
				// Send parameters
				
				
				
		},
			to: goodURL,
			encodingCompletion: { encodingResult in
				switch encodingResult {
				case .success(let upload, _, _):
					upload.responseJSON { response in
						//debugPrint("SUCCESS RESPONSE: \(response)")
					}
				case .failure(let encodingError):
					print("")
					//print("ERROR RESPONSE: \(encodingError)")
					
				}
		}
		)
		self.dismiss(animated: true, completion: {})

		
	}
	@IBAction func uploadButtonPressed(_ sender: Any) {
		imagePicker.allowsEditing = false
		imagePicker.sourceType = .photoLibrary
		present(imagePicker, animated: true, completion: nil)

	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
			image.contentMode = .scaleAspectFit
			image.image = pickedImage
		}
		dismiss(animated: true, completion: {})
	}

	
	
	@IBAction func cancel(_ sender: Any) {
		self.dismiss(animated: true, completion: {})
	}
	
}







