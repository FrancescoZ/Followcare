//
//  ImageCommentViewController.swift
//  Follocare
//
//  Created by Francesco Zanoli on 22/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

import UIKit
import SwiftInstagram
import Koloda
import NVActivityIndicatorView

class ImageCommentViewController: UIViewController {

    @IBOutlet weak var landscapeButton: UIButton!
    @IBOutlet weak var lighButton: UIButton!
    @IBOutlet weak var compositionButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var imageView: KolodaView!
    
    @IBOutlet var activityIndicatorView:NVActivityIndicatorView!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    var user:User!
    var toShow:Array<InstagramMedia> = []
    var showStarted = false
    let api = Instagram.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = User(username:"fra", photo:URL(string:"http://facebook.com")! ,initFollowers:0)
        self.delegate.user = self.user
        activityIndicatorView.type = .ballRotateChase
        activityIndicatorView.color = UIColor.black
        activityIndicatorView.startAnimating()
        if !api.isAuthenticated {
            if let nav = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                self.api.login(from: nav, withScopes: [.likes, .comments, .followerList, .publicContent], success: {
                    print("Login successfull")
                    self.initUser()
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
        else{
            self.initUser()
        }
        
        imageView.dataSource = self
        imageView.delegate = self
       
    }

    func initUser(){
        /*self.api.user("self", success: { usr in
            self.user = User(username:usr.username, photo:usr.profilePicture,initFollowers:(usr.counts?.followedBy)!)
            self.delegate.user = self.user
            self.getImages()
        }, failure: { error in
            print(error.localizedDescription)
        })*/
    }
    
    func getImages(){
        self.api.recentMedia(fromUser: "self", success: { medias in
            medias.forEach{ (media) in
                self.api.comments(fromMedia: media.id, success: { comments in
                    self.user.addFollowers(comments.filter({ (comment) -> Bool in
                        return comment.from.username != self.user.username &&
                            comment.from.username != ""
                    }).map({ (comment) -> String in
                        return comment.from.id
                    }))
                    self.loadImage()
                    
                }, failure: { error in
                    print(error.localizedDescription)
                })
            }
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    func loadImage(){
        self.user.activeFollowers.forEach { (follower) in
            self.api.recentMedia(fromUser: follower, count: self.user.setting.mediaPerFollower, success: { (medias) in
                var count = 0
                medias.forEach{ (media) in
                    self.api.comments(fromMedia: media.id, success: { comments in
                        count += 1
                        if !comments.contains(where: { (com) -> Bool in
                            return com.from.username == self.user.username
                        }) && !self.toShow.contains(where: { (m) -> Bool in
                            return m.id == media.id
                        }){
                            self.toShow.append(media)
                            if (count == medias.count){
                                self.updateView()
                                self.activityIndicatorView.stopAnimating()
                            }
                        }
                    }, failure: { error in
                        print(error.localizedDescription)
                    })
                    
                }
            }, failure: { (error) in
                print(error.localizedDescription)
            })
        }
    }
    
    func updateView(){
        self.imageView.reloadData()
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

    @IBAction func commentTouch(_ sender: UIButton) {
        var comment = ""
        
        switch sender.restorationIdentifier! {
        case "likeButton":
            comment = self.user.setting.getLikeComment()
            break
        case "photoButton":
            comment = self.user.setting.getPhotoComment()
            break
        case "editButton":
            comment = self.user.setting.getEditComment()
            break
        case "compositionButton":
            comment = self.user.setting.getCompositionComment()
            break
        case "lightButton":
            comment = self.user.setting.getLightComment()
            break
        case "randomButton":
            comment = self.user.setting.getRandomComment()
            break
        case "landscapeButton":
            comment = self.user.setting.getLandscapeComment()
            break
        case "fireButton":
            comment = self.user.setting.getFireComment()
            break
        default:
            break
        }
        let index = self.imageView.currentCardIndex
        self.api.createComment(onMedia: self.toShow[index].id,
                               text: comment,
                               success: {data in print(data)},
                               failure: {error in print(error.localizedDescription)})
        self.imageView.swipe(SwipeResultDirection.left)
        self.toShow.remove(at: index)
    }
}

//KOLODA VIEW CODE
extension ImageCommentViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
        print(index)
    }
}


extension ImageCommentViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return toShow.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let data = try? Data(contentsOf: toShow[index].images.lowResolution.url)
        return UIImageView(image: UIImage(data: data!))
    }
}
