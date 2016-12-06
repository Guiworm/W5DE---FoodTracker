//
//  LoginViewController.swift
//  FoodTracker
//
//  Created by Dylan McCrindle on 2016-12-05.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: Actions
	@IBAction func submitLogin(_ sender: UIButton) {
		let postData = [
			"username": usernameField.text ?? "",
			"password": passwordField.text ?? ""
		]
		
		APIManager().loginSignup(postData: postData, completion: { (status: String) in
			let alert = UIAlertController(title: status,
			                              message: "",
			                              preferredStyle: UIAlertControllerStyle.alert)
			
			alert.addAction(UIAlertAction(title: "OK",
			                              style: UIAlertActionStyle.default,
			                              handler: nil))
			
			self.present(alert, animated: true, completion: nil)

		})
		
		
	}
}
