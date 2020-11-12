

import UIKit
import LanguageManager_iOS

@IBDesignable
class CollectionViewWithTitleView: UIView {

    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var seeAllBlock: (() -> ())?
    var showItemDetailsBlock: ((String,Bool) -> ())?
    var successCall: ((String) -> ())?
    var isPriceHidden: Bool = true
    
    fileprivate var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(loadViewFromNib(viewClass: self.classForCoder))
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.addSubview(loadViewFromNib(viewClass: self.classForCoder))
    }

    @IBAction func seeAllButtonClick(_ sender: Any) {
        seeAllBlock?()
    }
}

