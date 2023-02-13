//
//  BottomSheetViewController.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 23/07/22.
//

import UIKit

class BottomSheetViewController: UIViewController {

    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var optionContainer: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOverlay(_:)))
        overlayView.addGestureRecognizer(tapGesture)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        optionContainer.animateBottomSheet(show: true){}
    }
    
    @objc func didTapOverlay (_ sender : UIGestureRecognizer){
        optionContainer.animateBottomSheet(show: false) {
        self.dismiss(animated: false)
        
        }
    }
    

}
