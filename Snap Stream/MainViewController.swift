//
//  ViewController.swift
//  Snap Stream
//
//  Created by Steven DiCarlo on 3/25/17.
//  Copyright © 2017 Steven DiCarlo. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UITableViewController, CLLocationManagerDelegate {

	var locManager = CLLocationManager()
	@IBOutlet var eventsTable: UITableView!
	@IBOutlet weak var newEventButton: UIBarButtonItem!
	var refresher: UIRefreshControl = UIRefreshControl()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		locManager.delegate = self
		locManager.requestWhenInUseAuthorization()
		locManager.startUpdatingLocation()
		getEventsData()
		
		
		refresher.attributedTitle = NSAttributedString(string:"Pull to Refresh")
		refresher.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
		eventsTable.addSubview(refresher)
		
		let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refresh), userInfo: nil, repeats: false)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1;
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allEvents.count;
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let aCell = self.eventsTable.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
		if let url = NSURL(string: allEvents[indexPath.row].thumbnail) {
			if let data = NSData(contentsOf: url as URL) {
				aCell.thumb.image = UIImage(data: data as Data)
			}
		}
		aCell.name.text = allEvents[indexPath.row].name
		return aCell

	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "clickedEvent", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "clickedEvent"{
			guard let upcoming: EventViewController = segue.destination as? EventViewController else{
				print("bad")
				return
			}
			guard let indexPath: IndexPath = self.eventsTable.indexPathForSelectedRow  else{
				print("no index path")
				return
			}
			upcoming.thisEvent = allEvents[indexPath.row]
			self.eventsTable.deselectRow(at: indexPath, animated: true)

		}
		if segue.identifier == "newEventSegue"{}
			
	
	
	}
	
	
	
	@IBAction func addButtonPressed(_ sender: Any) {
		self.performSegue(withIdentifier: "newEventSegue", sender: self)

	}
	
	@IBAction func cancelNewEvent(segue: UIStoryboardSegue){
		
	}

	
	
	
	func refresh(){
		getEventsData()
		let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(refresh2), userInfo: nil, repeats: false)
		refresher.endRefreshing()
	}
	
	
	
	func refresh2(){
		eventsTable.reloadData()
	}
	
}
