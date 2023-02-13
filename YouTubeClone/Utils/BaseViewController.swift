//
//  BaseViewController.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 27/07/22.
//

import UIKit

enum LoadingViewState{
    case show
    case hide
}

protocol BaseViewProtocol{
    func loadingView(_ state : LoadingViewState)
    func showError(_ error : String, callback : (()->Void)?)
}

class BaseViewController: UIViewController {
    var loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func configNavigationBAr(){
     
        let stackOptions = UIStackView()
        stackOptions.axis = .horizontal
        stackOptions.distribution = .fillEqually
        stackOptions.spacing = 0.0
        stackOptions.translatesAutoresizingMaskIntoConstraints = false
        
        let share = builtButtons(selector: #selector(shareButtonPressed), image: UIImage(named: "cast")?.withRenderingMode(.alwaysTemplate) ?? UIImage(), inset: 30)
        let magnify = builtButtons(selector: #selector(magnifyButtonPressed), image: UIImage(named: "magnifying")?.withRenderingMode(.alwaysTemplate) ?? UIImage(), inset: 33)
        let dots = builtButtons(selector: #selector(dotsButtonPressed), image: UIImage(named: "dots")?.withRenderingMode(.alwaysTemplate) ?? UIImage(), inset: 33)
        
        stackOptions.addArrangedSubview(share)
        stackOptions.addArrangedSubview(magnify)
        stackOptions.addArrangedSubview(dots)
        
        stackOptions.widthAnchor.constraint(equalToConstant: 120).isActive = true
        let customItemView = UIBarButtonItem(customView: stackOptions)
        customItemView.tintColor = .clear
        navigationItem.rightBarButtonItem = customItemView

    }
    
    private func builtButtons(selector : Selector, image : UIImage, inset : CGFloat) -> UIButton{
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor (named: "whiteColor")
        let extraPadding : CGFloat = 2.0
        button.imageEdgeInsets = UIEdgeInsets(top: inset+extraPadding, left: inset, bottom: inset+extraPadding, right: inset)
        return button
        
    }
    
    @objc func shareButtonPressed(){
        print("shareButtonPressed")
       
    }
    @objc func magnifyButtonPressed(){
        print("magnigyButtonPressed")
    }
    @objc func dotsButtonPressed(){
        print("dotsButtonPressed")
    }

}

extension BaseViewController{
    func showError(_ error : String, callback : (()->Void)?){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        if let callback = callback{
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                if action.style == .default{
                    callback()
                    print("retry button pressed")
                }
            }))
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            if action.style == .cancel{
                print("ok button pressed")
            }
        }))
        
        present(alert, animated: true)
    }
    
    func loadingView(_ state : LoadingViewState){
        switch state {
        case .show:
            showLoading()
        case .hide:
            hideLoading()
        }
    }
    
    private func showLoading(){
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        loadingIndicator.startAnimating()
    }
    
    private func hideLoading(){
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
    
}

