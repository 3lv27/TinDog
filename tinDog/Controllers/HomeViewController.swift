//
//  HomeViewController.swift
//  tinDog
//
//  Created by Elvin Gomez on 21/05/2018.
//  Copyright © 2018 Elvin Gomez. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleView = NavigationImageView()
        titleView.image = UIImage(named: "Actions")
        self.navigationItem.titleView = titleView
        let homeGR = UIPanGestureRecognizer(target: self, action: #selector(cardDragged(gestureRecongnizer: )))
        self.cardView.addGestureRecognizer(homeGR)
        // Do any additional setup after loading the view.
    }
    
    @objc func cardDragged(gestureRecongnizer: UIPanGestureRecognizer) {
//        print("Drag\(gestureRecongnizer.translation(in: view))")
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
//            print(self.cardView.center.x)
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
