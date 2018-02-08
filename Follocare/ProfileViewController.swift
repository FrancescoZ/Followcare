//
//  ProfileViewController.swift
//  Follocare
//
//  Created by Francesco Zanoli on 07/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usrProfileImage:UIImageView!
    @IBOutlet weak var usrName:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usrProfileImage.layer.cornerRadius = self.usrProfileImage.frame.size.width / 2;
        self.usrProfileImage.clipsToBounds = true;
        
        self.usrProfileImage.layer.borderWidth = 3.0;
        self.usrProfileImage.layer.borderColor = UIColor.white.cgColor;
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
