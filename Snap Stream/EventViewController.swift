//
//  EventViewController.swift
//  Snap Stream
//
//  Created by Steven DiCarlo on 3/25/17.
//  Copyright © 2017 Steven DiCarlo. All rights reserved.
//

import UIKit
import Agrume

class EventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
	
	var thisEvent: Event!
	@IBOutlet weak var titleBar: UINavigationItem!
	@IBOutlet weak var collectionView: UICollectionView!
	var refresher = UIRefreshControl()
	
	override func viewDidLoad() {
		collectionView.delegate = self
		collectionView.dataSource = self
		titleBar.title = thisEvent.name
		
		refresher.attributedTitle = NSAttributedString(string:"Pull to Refresh")
		refresher.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
		collectionView.addSubview(refresher)
		collectionView.alwaysBounceVertical = true
		
		
		super.viewDidLoad()
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let aCell:ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell

		

		aCell.backgroundColor = UIColor.white
		let origLink = thisEvent.pictures[indexPath.row].link
		let index = origLink.index(origLink.startIndex, offsetBy: 28)
		let firstPart = origLink.substring(to: index)
		let lastPart = origLink.substring(from: index)
		let thumb = firstPart + "thumb." + lastPart
		if let url = NSURL(string: thumb) {
			if let data = NSData(contentsOf: url as URL) {
				aCell.image.image = UIImage(data: data as Data)
			}
		}
		
		return aCell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		var urls = [URL]()
		for pic in thisEvent.pictures{
			if let url = URL(string: pic.link) {
				urls.append(url)
			}
		}
		let agrume = Agrume(imageUrls: urls, startIndex: indexPath.row, backgroundBlurStyle: .light, backgroundColor: .white)
		agrume.didScroll = { [unowned self] index in
			self.collectionView?.scrollToItem(at: IndexPath(row:index, section: 0),
			                                  at: [],
			                                  animated: false)
		}

		agrume.showFrom(self)
	}

	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1;
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return thisEvent.pictures.count
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "newPhotoSegue"{
			let upcoming = segue.destination as! NewPictureViewController
			upcoming.thisEvent = self.thisEvent
			upcoming.sourceViewController = self
		}
	}
	
	

	
	
	func refresh(){
		let id = thisEvent.id
		getEventsData()
		getOneEvent(id: String(describing: id))
		let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refresh2), userInfo: nil, repeats: false)

	}
	


	func refresh2(){

		thisEvent = singleEvent[0]
		collectionView.reloadData()
		
		refresher.endRefreshing()

	}



































}
