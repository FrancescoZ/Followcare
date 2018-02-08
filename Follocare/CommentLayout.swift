//
//  CommentLayout.swift
//  Follocare
//
//  Created by Francesco Zanoli on 04/01/2018.
//  Copyright © 2018 Francesco Zanoli. All rights reserved.
//

import UIKit

protocol CommentLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView,
                        heightForCommentAtIndexPath indexPath:IndexPath) -> CGFloat
}

class CommentLayout: UICollectionViewLayout {
    //This keeps a reference to the delegate.
    weak var delegate: CommentLayoutDelegate!
    
    //Two properties for configuring the layout: the number of columns and the
    //cell padding.
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    
    //array to cache the calculated attributes
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    //to store the content size.
    fileprivate var contentHeight: CGFloat = 0
    
    var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    //to return the size of the collection view’s contents
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        //only calculate the layout attributes if cache is empty and the
        //collection view exists
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        //This declares and fills the xOffset array with the x-coordinate for
        //every column based on the column widths. The yOffset array tracks the
        //y-position for every column.
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        //This loops through all the items in the first section, as this
        //particular layout has only one section.
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            /*frame calculation. width is the previously calculated cellWidth,
            * with the padding between cells removed. You ask the delegate for the
            * height of the photo and calculate the frame height based on this
            * height and the predefined cellPadding for the top and bottom.
            * then combine this with the x and y offsets of the current column
            * to create the insetFrame used by the attribute.
             */
            let photoHeight = delegate.collectionView(collectionView, heightForCommentAtIndexPath: indexPath)
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            //creates an instance of UICollectionViewLayoutAttribute,
            //sets its frame using insetFrame and appends the attributes to cache.
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

}
