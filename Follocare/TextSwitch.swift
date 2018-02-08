//
//  TextSwitch.swift
//  Follocare
//
//  Created by Francesco Zanoli on 05/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

import UIKit

class TextSwitch: UICollectionViewCell {
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var textView:UILabel!
    
    let activeColor = UIColor(
        red: CGFloat(0.47),
        green: CGFloat(0.69),
        blue: CGFloat(0.97),
        alpha: CGFloat(1))
    let deactiveColor = UIColor(
        red: CGFloat(0.53),
        green: CGFloat(0.53),
        blue: CGFloat(0.53),
        alpha: CGFloat(1))

    var active:Bool? {
        didSet {
            if let act = active {
                self.toggleView(act)
            }
        }
        
    }
    var text:String?{
        didSet {
            if let str = text {
                self.textView.text = str
            }
        }
    }
    
    //MARK: Initialisation 
    //Init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView(text: "")
    }
    
    //init from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Private method
    private func setupView(text: String){
        //border
        self.layer.cornerRadius = 30.0
        self.layer.borderWidth = 1.0
        
        //content
        self.textView.text = text
        toggleView(true)
        
        let stack = UIStackView(arrangedSubviews: [self.imageView, self.textView])
        self.addSubview(stack)
        
        //Constraint
        self.imageView.widthAnchor.constraint(equalToConstant:50.0).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant:50.0).isActive = true
        
        self.textView.lineBreakMode = .byWordWrapping
        self.textView.numberOfLines = 10
        
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        //autolayout the stack view - pin 30 up 20 left 20 right 30 down
        let viewsDictionary = ["stackView":stack]
        let stackView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[stackView]-20-|",  //horizontal constraint 20 points from left and right side
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[stackView]-0-|", //vertical constraint 30 points from top and bottom
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        self.addConstraints(stackView_H)
        self.addConstraints(stackView_V)
        
        //autolayout the stack view - pin 30 up 20 left 20 right 30 down
        let dic = ["label":self.textView]
        let label_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-20-[label]-20-|", //vertical constraint 30 points from top and bottom
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: dic)
        stack.addConstraints(label_V)
        
        self.textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100.0).isActive = true
        self.textView.widthAnchor.constraint(equalToConstant: self.frame.width-80.0).isActive = true
    }
    
    func toggleView(_ value:Bool){
        if(value){
            self.backgroundColor = self.activeColor
            self.imageView.image = #imageLiteral(resourceName: "check-white")
            self.textView.textColor = UIColor.white
            self.layer.borderColor = self.activeColor.cgColor
            
           }else{
            self.backgroundColor = UIColor.white
            self.imageView.image = #imageLiteral(resourceName: "check-gray")
            self.textView.textColor = self.deactiveColor
            self.layer.borderColor = self.deactiveColor.cgColor
        }
    }
    
    //MARK: Action
    func toggleTextSwitch(){
        self.active = !self.active!
        toggleView(active!)
    }
    
    
    
}
