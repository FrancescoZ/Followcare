//
//  SettingCommentViewController.swift
//  Follocare
//
//  Created by Francesco Zanoli on 02/02/2018.
//  Copyright © 2018 Francesco Zanoli. All rights reserved.
//

import UIKit

class SettingCommentViewController: UIViewController {
    var user:User!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var contentWitdh:CGFloat = 0
    
    @IBOutlet weak var randomCollectionView:UICollectionView!
    //@IBOutlet weak var landscapCollectionView:UICollectionViewCell!
    override func viewDidLoad() {
        self.user = self.delegate.user
        randomCollectionView.delegate = self
        randomCollectionView.dataSource = self
        
        if let layout = randomCollectionView.collectionViewLayout as? CommentLayout {
            layout.delegate = self
            contentWitdh = layout.contentWidth
        }
    }
}

extension SettingCommentViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.user.setting.randomCommentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath)
        if let annotateCell = cell as? TextSwitch {
            annotateCell.text = self.user.setting.randomCommentList[indexPath.item].text
            annotateCell.active = self.user.setting.randomCommentList[indexPath.item].active
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellSelected = randomCollectionView.cellForItem(at: indexPath) as! TextSwitch
        cellSelected.toggleTextSwitch()
    }
    
}

extension SettingCommentViewController: CommentLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForCommentAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        let d = sizeOfString(string: self.user.setting.randomCommentList[indexPath.item].text,
                            constrainedToWidth: contentWitdh ).height
        return d + 100
    }
    
    func sizeOfString (string: String, constrainedToWidth width: CGFloat) -> CGSize {
        
        let attString = NSAttributedString(string: string)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), nil)
    }
}

