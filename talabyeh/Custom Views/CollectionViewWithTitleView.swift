

import UIKit
import LanguageManager_iOS

@IBDesignable
class CollectionViewWithTitleView: UIView/*,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout*/ {

    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var contentView: UIView?
    var seeAllBlock: ((Any) -> ())?
    var showItemDetailsBlock: ((String,Bool) -> ())?
    var successCall: ((String) -> ())?
    var isPriceHidden: Bool = true
    
    
//    var collectionViewDS: [ItemModel] = []{
//        didSet{
//          collectionView.reloadData()
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = UIColor.systemBackground
        self.addSubview(loadViewFromNib(viewClass: self.classForCoder))
        //collectionView.register(ItemCollectionViewCell.self)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //self.backgroundColor = UIColor.systemBackground
        self.addSubview(loadViewFromNib(viewClass: self.classForCoder))
        //collectionView.register(ItemCollectionViewCell.self)
    }

  
    @IBAction func seeAllButtonClick(_ sender: Any) {
        guard let actionBlock = seeAllBlock else { return }
        actionBlock (20)
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return collectionViewDS.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell:ItemCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
//        //cell.isPriceHidden = isPriceHidden
//        cell.setup(model: collectionViewDS[indexPath.row])
//        cell.itemActionButtons.viewItemDetails =  {
//            self.showIItemDetails(itemID: self.collectionViewDS[indexPath.row].productid!, shouldViewOptionsFirst: true)
//        }
//        cell.itemActionButtons.successCall = { value in
//            guard let actionBlock = self.successCall else { return }
//            actionBlock (value )
//        }
//        return cell
//    }
//
//    func showIItemDetails(itemID: String, shouldViewOptionsFirst : Bool = false){
//        guard let actionBlock = showItemDetailsBlock else { return }
//        actionBlock (itemID,shouldViewOptionsFirst )
//    }
    
 
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        showIItemDetails ( itemID: collectionViewDS[indexPath.row].productid ?? "" )
//    }
    
    
//    func collectionView(_ collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAt indexPath:IndexPath) -> CGSize
//    {
//        let padding: CGFloat =  20
//        let collectionViewSize = collectionView.frame.size.width - padding
//        let height = collectionView.frame.size.height
//        return CGSize(width: collectionViewSize/2, height: height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//    }
    
}

extension UIView{
    internal func loadViewFromNib(viewClass: Swift.AnyClass) -> UIView! {
        let bundle = Bundle(for: viewClass.self)
        let nib = UINib(nibName: String(describing: viewClass.self), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.semanticContentAttribute = LanguageManager.shared.currentLanguage == .en ? .forceLeftToRight : .forceRightToLeft
        return view
    }
}
