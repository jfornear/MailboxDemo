//
//  MailboxViewController.swift
//  MailboxDemo
//
//  Created by Jesse Fornear on 9/24/14.
//  Copyright (c) 2014 Jesse Fornear. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var navImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var helpImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var laterImage: UIImageView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var archiveImage: UIImageView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var rescheduleModalImage: UIImageView!
    @IBOutlet weak var listModalImage: UIImageView!
    
    var mainViewCenter = CGPoint()
    var messageCenter = CGPoint()
    var leftViewOrigin = CGPoint()
    var rightViewOrigin = CGPoint()
    
    let openMenuPosition = CGFloat(290)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scrollView.contentSize =
            CGSize(
                width: 320,
                height:
                (self.searchImage.image!.size.height +
                    self.helpImage.image!.size.height +
                    self.messageImage.image!.size.height +
                    self.feedImage.image!.size.height +
                    self.navImage.image!.size.height
                )
        )
        self.mainView.frame.origin.x = 0
        self.rightView.alpha = 0
        self.leftView.alpha = 0
        self.listImage.alpha = 0
        self.deleteImage.alpha = 0
        
        mainViewCenter = self.mainView.center
        messageCenter = self.messageImage.center
        leftViewOrigin = self.leftView.frame.origin
        rightViewOrigin = self.rightView.frame.origin
        
        var edgeGestureLeft = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePanLeft:")
        edgeGestureLeft.edges = UIRectEdge.Left
        self.mainView.addGestureRecognizer(edgeGestureLeft)

        var tapMenu = UITapGestureRecognizer(target: self, action: "onMainTap:")
        self.scrollView.addGestureRecognizer(tapMenu)
        
        var edgeGestureRight = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePanRight:")
        edgeGestureRight.edges = UIRectEdge.Right
        self.mainView.addGestureRecognizer(edgeGestureRight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanMessage(gestureRecognizer: UIPanGestureRecognizer) {
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)

        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            messageImage.center.x = translation.x + messageCenter.x
            
            if (translation.x > 0) {
                self.rightView.alpha = 0
                self.leftView.alpha = 1
            } else {
                self.rightView.alpha = 1
                self.leftView.alpha = 0
            }
            
            if (translation.x > -60 && translation.x < 0) {
                
            }
            else if (translation.x <= -60 && translation.x > -260) {
                self.rightView.frame.origin.x = translation.x + rightViewOrigin.x + abs(-60)
                self.laterImage.alpha = 1
                self.listImage.alpha = 0
                
                // yellow
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {
                    self.messageView.backgroundColor = UIColor(red: 249/255, green: 204/255, blue: 40/255, alpha: 1.0)
                    }, completion: nil)
            }
            else if (translation.x <= -260) {
                self.rightView.frame.origin.x = translation.x + rightViewOrigin.x + abs(-60)
                self.laterImage.alpha = 0
                self.listImage.alpha = 1
                
                // brown
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {
                    self.messageView.backgroundColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1.0)
                    }, completion: nil)
            }

            if (translation.x >= 60 && translation.x <= 260) {
                self.leftView.frame.origin.x = translation.x + leftViewOrigin.x - abs(60)
                self.archiveImage.alpha = 1
                self.deleteImage.alpha = 0
                
                // green
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {
                    self.messageView.backgroundColor = UIColor(red: 98/255, green: 213/255, blue: 80/255, alpha: 1.0)
                    }, completion: nil)
            }
            else if (translation.x >= 260) {
                self.leftView.frame.origin.x = translation.x + leftViewOrigin.x - abs(60)
                self.archiveImage.alpha = 0
                self.deleteImage.alpha = 1
                
                // red
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {
                    self.messageView.backgroundColor = UIColor(red: 228/255, green: 61/255, blue: 39/255, alpha: 1.0)
                    }, completion: nil)
            }


        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            if (translation.x > -60 && translation.x < 0) {
                self.messageView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 223/255, alpha: 1.0)
                
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {
                    self.messageImage.frame.origin.x = 0
                    }, completion: nil)
            }
            else if (translation.x <= -60 && translation.x > -260) {
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {

                    self.messageImage.frame.origin.x = -self.messageImage.image!.size.width
                    
                    self.rightView.frame.origin.x = abs(-60)
                    self.laterImage.alpha = 0
                    
                    self.modalView.alpha = 1
                    self.rescheduleModalImage.alpha = 1
                    },  completion: nil)
            }
            else if (translation.x <= -260) {
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {                    self.messageImage.frame.origin.x = -self.messageImage.image!.size.width
                    
                    
                    self.rightView.frame.origin.x = abs(-60)
                    self.listImage.alpha = 0
                    
                    self.modalView.alpha = 1
                    self.listModalImage.alpha = 1
                    },  completion: nil)
            }
            
            if (translation.x < 60 && translation.x > 0) {
                self.messageView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 223/255, alpha: 1.0)

                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {
                    self.messageImage.frame.origin.x = 0
                    }, completion: nil)
            }
            else if (translation.x >= 60 && translation.x <= 260) {
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {
                    self.messageImage.frame.origin.x = self.messageImage.image!.size.width * 2
                
                    self.leftView.frame.origin.x = self.messageImage.image!.size.width - abs(60)
                    self.archiveImage.alpha = 0
                    }) { (finished: Bool) -> Void in
                        self.resetMainView()
                }
            }
            else if (translation.x >= 260) {
                UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {
                    self.messageImage.frame.origin.x = self.messageImage.image!.size.width * 2
                    
                    self.leftView.frame.origin.x = self.messageImage.image!.size.width - abs(60)
                    self.deleteImage.alpha = 0
                    }) { (finished: Bool) -> Void in
                        self.resetMainView()
                }
            }

            
        }
    }
    
    @IBAction func onModalTap(sender: AnyObject) {
        resetMainView()
    }
    
    @IBAction func onMenuTap(sender: AnyObject) {
        if (self.mainView.frame.origin.x == self.openMenuPosition) {
            self.closeMenu()
        } else {
            self.openMenu()
        }
        println("onMenuTap")
    }
    
    func onEdgePanLeft(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {

        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            self.mainView.center.x = translation.x + mainViewCenter.x
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if (velocity.x >= 0) {
                openMenu()
            }
            else {
                closeMenu()
            }
        }
    }

    func onEdgePanRight(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        closeMenu()
    }
    
    func onMainTap(gestureRecognizer: UITapGestureRecognizer) {
        if (self.mainView.frame.origin.x == self.openMenuPosition) {
            closeMenu()
        }
        println("onMainTap \(self.mainView.frame.origin.x) \(self.openMenuPosition)")
    }

    func openMenu() {
        self.scrollView.scrollEnabled = false
        UIView.animateWithDuration(0.4, animations: {
            self.mainView.frame.origin.x = self.openMenuPosition
        })
    }

    func closeMenu() {
        self.scrollView.scrollEnabled = true
        UIView.animateWithDuration(0.3, animations: {
            self.mainView.frame.origin.x = 0
        })
    }

    
    func resetMainView() {
        self.listModalImage.alpha = 0
        self.rescheduleModalImage.alpha = 0
        self.modalView.alpha = 0
        
        UIView.animateWithDuration(0.2, delay: 0.1, options: nil, animations:{
            self.feedImage.frame.origin.y -= self.messageImage.image!.size.height
            }) { (finished: Bool) -> Void in
                
                self.messageImage.frame.origin.x = 0
                self.rightView.frame.origin.x = self.rightViewOrigin.x
                self.feedImage.frame.origin.y += self.messageImage.image!.size.height
                self.laterImage.alpha = 0
                self.archiveImage.alpha = 0
                self.messageView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 223/255, alpha: 1.0)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
