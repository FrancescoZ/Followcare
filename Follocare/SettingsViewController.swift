//
//  SettingsViewController.swift
//  Follocare
//
//  Created by Francesco Zanoli on 23/01/2018.
//  Copyright © 2018 Francesco Zanoli. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var sliderRecentMedia:UISlider!
    @IBOutlet weak var sliderMaxComment:UISlider!
    
    @IBOutlet weak var onlyRecentSwitch:UISwitch!
    
    @IBOutlet weak var recentMediaLabel:UILabel!
    @IBOutlet weak var MaxCommentLabel:UILabel!
    
    var user:User!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = self.delegate.user
        sliderRecentMedia.value = Float(user.setting.mediaPerFollower)
        sliderMaxComment.value = Float(user.setting.maxCommentPerDay)
        
        onlyRecentSwitch.isOn = user.setting.onlyRecentMedia
        MaxCommentLabel.text = String(user.setting.maxCommentPerDay)
        recentMediaLabel.text = String(user.setting.mediaPerFollower)
    }
    
    
    ///MARK - Action
    @IBAction func sliderChanged(_ sender: UISlider) {
        if (sender == self.sliderMaxComment){
            user.setting.maxCommentPerDay = Int(sender.value)
            MaxCommentLabel.text = String(user.setting.maxCommentPerDay)
        }
        else{
            user.setting.mediaPerFollower = Int(sender.value)
            recentMediaLabel.text = String(user.setting.mediaPerFollower)
        }
        self.delegate.user = self.user
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        user.setting.onlyRecentMedia = onlyRecentSwitch.isOn
        self.delegate.user = self.user
    }
    
    
}
