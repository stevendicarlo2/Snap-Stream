//
//  Parse Info.swift
//  Snap Stream
//
//  Created by Steven DiCarlo on 3/25/17.
//  Copyright © 2017 Steven DiCarlo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Picture{
	var id: Int
	var date: NSDate
	var link: String
	var vote: Int
	var reported: Bool
	var uploadedby: String
    var thumbnail: String
}

struct Event{
	var id : Int
	var name: String
	var lat: Double
	var lon: Double
	var date: NSDate
	var thumbnail: String
	var pictures :  [Picture]
}

var allEvents: [Event] = [Event]()
var singleEvent: [Event] = []


let latitude = 38.040986
let longitude = -78.503890


func getEventsData(){
	allEvents = [Event]()
	let theURL : String = "http://34.206.97.137/events?lat=" + String(latitude) + "&lon=" + String(longitude)
	Alamofire.request(theURL).responseJSON{response in
		let json = JSON(response.result.value!)
		convertJSONToEvents(json: json)
	}
}

func getOneEvent(id: String){
	let theURL : String = "http://34.206.97.137/event?id=" + id
	Alamofire.request(theURL).responseJSON{response in
		let json = JSON(response.result.value!)
		convertJSONToEvent(json: json)
	}

}

func convertJSONToEvent(json: JSON){
	singleEvent = []
	let thumbnail = String(describing: json["thumbnail"]),  id = Int(String(describing: json["id"]))!,  dateString = String(describing: json["date"]),  lon = Double(String(describing: json["lon"]))!,  lat = Double(String(describing: json["lat"]))!,  name = String(describing: json["name"])
	let date = NSDate()
	let pictures = convertJSONToPicture(json: json["pictures"])
	let newEvent = Event(id: id, name: name, lat: lat, lon: lon, date: date, thumbnail: thumbnail, pictures: pictures)
	singleEvent.append(newEvent)
	
}

func convertJSONToEvents(json: JSON){
	guard json.count > 0 else {return}

	for i in 0...json.count-1{
		
		let thumbnail = String(describing: json[i]["thumbnail"]),  id = Int(String(describing: json[i]["id"]))!,  dateString = String(describing: json[i]["date"]),  lon = Double(String(describing: json[i]["lon"]))!,  lat = Double(String(describing: json[i]["lat"]))!,  name = String(describing: json[i]["name"])
		
		let date = NSDate()
		let pictures = convertJSONToPicture(json: json[i]["pictures"])
		let newEvent = Event(id: id, name: name, lat: lat, lon: lon, date: date, thumbnail: thumbnail, pictures: pictures)
		allEvents.append(newEvent)
	}
}


func convertJSONToPicture(json: JSON) -> [Picture]{
	var array : [Picture] = []
	guard json.count > 0 else {return array}
	for i in 0...json.count-1{
		let link = String(describing: json[i]["link"]), id = Int(String(describing: json[i]["id"]))!, uploadedby = String(describing: json[i]["uploadedby"]), vote = Int(String(describing: json[i]["vote"]))!, reportedString = String(describing: json[i]["reported"]), dateString = String(describing: json[i]["date"]), thumbnail =  String(describing: json[i]["thumbnail"])
		var reported = true
		if reportedString == "False" {reported = false}
		let date = NSDate()
        let newPic = Picture(id: id, date: date, link: link, vote: vote, reported: reported, uploadedby: uploadedby, thumbnail: thumbnail)
		array.append(newPic)
	}
	return array
}














