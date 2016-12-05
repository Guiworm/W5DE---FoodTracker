//
//  APIManager.swift
//  FoodTracker
//
//  Created by Dylan McCrindle on 2016-12-05.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class APIManager: NSObject {

	
	func login(postData : [String:String]) -> Void {
		
		
		guard let postJSON = try? JSONSerialization.data(withJSONObject: postData, options: []) else {
			print("could not serialize json")
			return
		}
		
		let defaults = UserDefaults.standard
		let req : NSMutableURLRequest
		
		if (defaults.string(forKey: "userUsername") != nil && defaults.string(forKey: "userPassword") != nil){
			req = NSMutableURLRequest(url: NSURL(string:"http://159.203.243.24:8000/login")! as URL)
		}
		else{
			req = NSMutableURLRequest(url: NSURL(string:"http://159.203.243.24:8000/signup")! as URL)
		}
		
		
		req.httpBody = postJSON
		req.httpMethod = "POST"
		req.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let task = URLSession.shared.dataTask(with: req as URLRequest) { (data, resp, err) in
			
			guard let data = data else {
				print("no data returned from server \(err)")
				return
			}
			
			guard let resp = resp as? HTTPURLResponse else {
				print("no response returned from server \(err)")
				return
			}
			
			
			
			guard let rawJson = try? JSONSerialization.jsonObject(with: data, options: []) else {
				print("data returned is not json, or not valid")
				return
			}
			
			guard let response = rawJson as? [String:[String:String]] else { return }
			
			guard (resp.statusCode >= 200  && resp.statusCode < 300) else {
				// handle error
				print("an error occurred \(response["error"])")
				return
			}
			
			// do something with the data returned (decode json, save to user defaults, etc.)
			
			
			if let userDict = response["user"] {
				let defaults = UserDefaults.standard
				defaults.set(userDict["token"]! as String, forKey: "userToken")
				defaults.set(userDict["username"]! as String, forKey: "userUsername")
				defaults.set(userDict["password"]! as String, forKey: "userPassword")
			}
			
		}
		
		task.resume()
	}
	
}


