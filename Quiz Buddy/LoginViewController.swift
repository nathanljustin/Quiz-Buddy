//
//  LoginViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/13/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController, LoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accessToken = AccessToken.current
        
        // Do any additional setup after loading the view.
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.delegate = self
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        // User has logged in
        
        let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // Error handle this
                print(error.localizedDescription)
                return
            }
            // Successfully logged in using Facebook and Firebase
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        // Logged out
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
