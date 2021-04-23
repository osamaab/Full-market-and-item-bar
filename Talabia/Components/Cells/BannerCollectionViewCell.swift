//
//  BannerCollectionViewCell.swift
//  Talabia
//
//  Created by Osama Abu hdba on 09/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import FSPagerView

class BannerCollectionViewCell: UICollectionViewCell{
    
    var pagerView: FSPagerView = FSPagerView(frame:.zero)
    var pageControl: FSPageControl = FSPageControl(frame:.zero)
    
    private var items: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupUI()
    }
    
    private func setupUI() {
        pagerView.frame = CGRect(x: 0, y: 0, width: view.layer.frame.width, height: view.layer.frame.height + 15)
        pageControl.frame = CGRect(x: 5, y: view.layer.frame.height - 10, width: 100, height: 30)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval = 6.0
        pagerView.isInfinite = true
        pagerView.decelerationDistance = 1
        pagerView.interitemSpacing = 10
        pagerView.transformer = FSPagerViewTransformer(type: .cubic)
        pageControl.contentHorizontalAlignment = .left
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pageControl.setStrokeColor(UIColor.white, for: .normal)
        pageControl.setStrokeColor(UIColor.white, for: .selected)
        pageControl.setFillColor(DefaultColorsProvider.tintPrimary, for: .selected)
        pageControl.itemSpacing = 10
    }
    
    func setupPagerView( items: [String]) {
        self.items = items
        pagerView.reloadData()
        pageControl.reloadInputViews()
        pageControl.numberOfPages = items.count

    }
    
    fileprivate func setup() {
        subviewsPreparedAL {
            pagerView
            pagerView.subviews{
                pageControl
            }
        }
        
        guard let superview = superview else {
            return
        }
        
//        pagerView.addSubview(pageControl)
        view.height(140)
        pagerView.Width == view.Width
        pagerView.Top == view.Top
        pagerView.Height == superview.view.Height
        pagerView.leading(0).trailing(0)
//        superview.addSubview(pageControl)
        pageControl.Leading == pagerView.Leading + 5
        pageControl.bottom(5)
        pageControl.width(70).height(30)
        
    }
}
extension BannerCollectionViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return items?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: items?[index] ?? "")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.clipsToBounds = false
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
        
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
}
