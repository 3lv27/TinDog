//
//  LoginViewController.swift
//  tinDog
//
//  Created by Elvin Gomez on 22/05/2018.
//  Copyright © 2018 Elvin Gomez. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    var signupMode = true
    
    @IBAction func closeModalLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signupActionBtn(_ sender: Any) {
        if self.emailInput.text == "" || self.passwordInput.text == "" {
            self.showAlert(title: "Error", message: "Fields can't be empty")
            
        } else {
            if let email = self.emailInput.text {
                if let password = self.passwordInput.text {
                    if signupMode{
                        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
                            if error != nil {
                                self.showAlert(title: "Error", message: error!.localizedDescription)
                            }else{
                                print("Signed up!")
                                if let user = user {
                                    let userData = ["provider": user.providerID, "email": user.email, "profileImage": "", "nickName": ""] as [String: Any]
                                    DataBaseService.instance.createUser(uid: user.uid, userData: userData)
                                }
                            }
                        })
                    } else {
                        Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
                            if error != nil {
                                self.showAlert(title: "Error", message: error!.localizedDescription)
                            }else{
                                print("eyoooo")
                            }
                        })
                    }
                }
            }
        }
    }
    
    @IBAction func loginActionBtn(_ sender: Any) {
        if self.signupMode {
            self.signupBtn.setTitle("Login", for: .normal)
            self.loginLabel.text = "Don't you have an account?"
            self.loginBtn.setTitle("Signup", for: .normal)
            self.signupMode = false
        } else {
            self.signupBtn.setTitle("Signup", for: .normal)
            self.loginLabel.text = "Do you already have an account?"
            self.loginBtn.setTitle("Login", for: .normal)
            self.signupMode = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bindKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
