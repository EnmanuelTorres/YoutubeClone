//
//  TabsView.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 2/08/22.
//

import Foundation
import UIKit
import SwiftUI

protocol TabsViewProtocol : AnyObject {
    func didSelectOption(index : Int)
}
class TabsView : UIView {
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor (named: "backgroundColor")
        
        
        //register cell
        collection.register(UINib(nibName: "\(OptionCell.self)", bundle: nil), forCellWithReuseIdentifier:  "\(OptionCell.self)")
        
        
        return collection
    }()
    
    var underline : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "whiteColor")
        //UIColor (named: "whiteColor")
        return view
    }()
    var selectedItem : IndexPath = IndexPath(item: 0, section: 0)
    var leadingConstraint : NSLayoutConstraint?
    var withCinstraint : NSLayoutConstraint?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configCollectionView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    private var options : [String] = []
    weak private var delegate : TabsViewProtocol?
    
    func buidView(delegate: TabsViewProtocol, options : [String]){
        self.delegate = delegate
        self.options = options
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
        self.configUnderline()
        }
        
    }
    
    private func configCollectionView(){
        addSubview(collectionView)
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: topAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    
    func configUnderline(){
        addSubview(underline)
        NSLayoutConstraint.activate([underline.heightAnchor.constraint(equalToConstant: 2.0),
                                     underline.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        let currentCell = collectionView.cellForItem(at: selectedItem)!
        withCinstraint = underline.widthAnchor.constraint(equalToConstant: currentCell.frame.width)
        withCinstraint?.isActive = true
        
        leadingConstraint = underline.leadingAnchor.constraint(equalTo: currentCell.leadingAnchor)
        leadingConstraint?.isActive = true
    }
    
    func updateUnderline(xOrigin : CGFloat, width : CGFloat){
        leadingConstraint?.constant = xOrigin
        withCinstraint?.constant = width
        layoutIfNeeded()
    }
    
}

extension TabsView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "\(OptionCell.self)", for: indexPath) as? OptionCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0{
            cell.highlightTitle(UIColor(named: "whiteColor")!)
        }else {
            cell.isSelected = (selectedItem.item == indexPath.row)
        }
        cell.configCell(option: options[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectOption(index: indexPath.item)
    }
    
}

extension TabsView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel()
        label.text = options[indexPath.item]
        label.font = UIFont.systemFont(ofSize: 16)
        let extraPadding : CGFloat = 20.0
        
        return CGSize(width: label.intrinsicContentSize.width+extraPadding, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
