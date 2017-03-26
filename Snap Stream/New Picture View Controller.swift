//
//  New Picture View Controller.swift
//  Snap Stream
//
//  Created by Steven DiCarlo on 3/25/17.
//  Copyright © 2017 Steven DiCarlo. All rights reserved.
//

import UIKit
import Alamofire

class NewPictureViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	
	var thisEvent: Event!
	var sourceViewController : EventViewController!
	@IBOutlet weak var cameraRollButton: UIButton!
	@IBOutlet weak var pictureButton: UIButton!
	@IBOutlet weak var uploadButton: UIButton!
	let imagePicker = UIImagePickerController()
	@IBOutlet weak var image: UIImageView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imagePicker.delegate = self
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	@IBAction func uploadButtonPressed(_ sender: Any) {
		let url = "http://34.206.97.137/addpicture?user=" + "steve" + "&event=" + String(describing: thisEvent.id)
		
		Alamofire.upload(
			multipartFormData: { multipartFormData in
				multipartFormData.append(UIImageJPEGRepresentation(self.image.image!, 1)!, withName: "file", fileName: "picture.jpg", mimeType: "image/jpeg")
				
				// Send parameters
				
				
				
		},
			to: url,
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
		let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(transitionBack), userInfo: nil, repeats: false)
		
	}
	func transitionBack(){
		guard let nav = self.navigationController else {
			return
		}
		sourceViewController.refresh()
		nav.popViewController(animated: true)

	}
	
	
	@IBAction func pictureButtonPressed(_ sender: Any) {
		imagePicker.allowsEditing = false
		imagePicker.sourceType = .camera
		present(imagePicker, animated: true, completion: nil)

	}
	@IBAction func cameraRollPressed(_ sender: Any) {
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
