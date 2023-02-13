//
//  OptionCell.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 2/08/22.
//

import UIKit

class OptionCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override var isSelected: Bool{
        didSet{
            highlightTitle(isSelected ? UIColor (named: "whiteColor")! : UIColor (named: "grayColor")!)

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func highlightTitle (_ color : UIColor){
        titleLabel.textColor = color
    }
    func configCell(option : String){
        titleLabel.text = option
        
    }

}
