//
//  HomeViewController.swift
//  tinDog
//
//  Created by Elvin Gomez on 21/05/2018.
//  Copyright © 2018 Elvin Gomez. All rights reserved.
//

import UIKit
import RevealingSplashView

class NavigationImageView : UIImageView {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 76, height: 39)
    }
}

class HomeViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var homeWrapper: UIStackView!
    @IBOutlet weak var likedImage: UIImageView!
    @IBOutlet weak var nopeImage: UIImageView!
    let revealingSplashScreen = RevealingSplashView(iconImage: UIImage(named:"splash_icon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting Splash screen animation
        self.view.addSubview(self.revealingSplashScreen)
        self.revealingSplashScreen.animationType = SplashAnimationType.popAndZoomOut
        self.revealingSplashScreen.startAnimation()
        
        let titleView = NavigationImageView()
        titleView.image = UIImage(named: "Actions")
        self.navigationItem.titleView = titleView
        let homeGR = UIPanGestureRecognizer(target: self, action: #selector(cardDragged(gestureRecongnizer: )))
        self.cardView.addGestureRecognizer(homeGR)
        
        let userLoginBtn = UIButton(type: .custom)
        userLoginBtn.setImage(UIImage(named: "login"), for: .normal)
        userLoginBtn.imageView?.contentMode = .scaleAspectFit
        userLoginBtn.addTarget(self, action: #selector(goToLogin(sender:)), for: .touchUpInside)
        let userLoginBarBtn = UIBarButtonItem(customView: userLoginBtn)
        self.navigationItem.leftBarButtonItem = userLoginBarBtn
       
    }
    
    @objc func goToLogin(sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginVC")
        present(loginViewController, animated: true, completion: nil)
        
    }
    
    
    @objc func cardDragged(gestureRecongnizer: UIPanGestureRecognizer) {

        let cardPoint = gestureRecongnizer.translation(in: view)
        self.cardView.center = CGPoint(x: self.view.bounds.width / 2 + cardPoint.x, y: self.view.bounds.height / 2 + cardPoint.y)
        
        let xFromCenter = self.view.bounds.width / 2 - self.cardView.center.x
        var rotate = CGAffineTransform(rotationAngle: xFromCenter / 200)
        let scale = min(100 / abs(xFromCenter), 1)
        var finalTransform = rotate.scaledBy(x: scale, y: scale)
        
        self.cardView.transform = finalTransform
        
        if self.cardView.center.x < (self.view.bounds.width / 2 - 100) {
            print("Dislike")
            self.nopeImage.alpha = min(abs(xFromCenter) / 100, 1)
        }
        
        if self.cardView.center.x > (self.view.bounds.width / 2 + 100) {
            print("Like")
            self.likedImage.alpha = min(abs(xFromCenter) / 100, 1)
        }
        
        
        
        if gestureRecongnizer.state == .ended {

            if self.cardView.center.x < (self.view.bounds.width / 2 - 100) {
                print("Dislike")
            }
            
            if self.cardView.center.x > (self.view.bounds.width / 2 + 100) {
                print("Like")
            }
            
            //Restarting card values..
            rotate = CGAffineTransform(rotationAngle: 0)
            finalTransform = rotate.scaledBy(x: 1, y: 1)
            self.cardView.transform = finalTransform
            self.likedImage.alpha = 0
            self.nopeImage.alpha = 0
            
            self.cardView.center = CGPoint(x: self.homeWrapper.bounds.width / 2, y: (self.homeWrapper.bounds.height / 2 - 30))
        }
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
