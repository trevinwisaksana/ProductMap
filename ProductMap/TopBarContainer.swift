//
//  TopBarContainer.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/23/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

protocol TopBarContainerDelegate: class {
    func dismissSearchView()
}

class TopBarContainer: UIView {
    
    var cancelSearchButton = UIButton()
    weak var delegate: TopBarContainerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.1
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setupTopBarContainer(_ viewController: UIViewController) {
        viewController.view.addSubview(self)
        
        // TopBarContainer setup
        let topBarFrame = CGRect(
            x: viewController.view.center.x,
            y: viewController.view.frame.height * 0.1,
            width: viewController.view.frame.width * 0.9,
            height: viewController.view.frame.height * 0.08
        )
        
        self.frame = topBarFrame
        self.center = CGPoint(
            x: viewController.view.center.x,
            y: viewController.view.center.y * 0.18
        )
        
        // Corner radius
        layer.cornerRadius = self.frame.width * 0.08
        
        delegate = viewController as? TopBarContainerDelegate
        
        // Setup cancel using the values of the container size
        setupCancelSearchButton()
    }
    
    
    public func setupCancelSearchButton() {
        self.addSubview(cancelSearchButton)
        
        let buttonFrame = CGRect(
            x: self.frame.origin.x * 0.25,
            y: self.frame.origin.x * 0.2,
            width: self.frame.size.width * 0.135,
            height: self.frame.size.width * 0.135
        )
        cancelSearchButton.frame = buttonFrame
        
        cancelSearchButton.clipsToBounds = true
        cancelSearchButton.alpha = 0
        cancelSearchButton.backgroundColor = UIColor(
            colorLiteralRed: 166/255,
            green: 159/255,
            blue: 135/255,
            alpha: 1
        )
        cancelSearchButton.layer.cornerRadius = cancelSearchButton.frame.width / 2
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(cancelSearchButtonHandler)
        )
        cancelSearchButton.addGestureRecognizer(tapGestureRecognizer)
        cancelSearchButton.setImage(
            UIImage(named: "CloseButton"),
            for: .normal
        )
        
    }
    
    
    @objc fileprivate func cancelSearchButtonHandler() {
        // Dismiss the search view
        delegate?.dismissSearchView()
        
        hideCancelButton()
    }
    
    
    public func showCancelButton() {
        UIView.animate(withDuration: 0.3, animations: {
            // Hide cancel button
            self.cancelSearchButton.alpha = 1
        })
    }
    
    
    public func hideCancelButton() {
        UIView.animate(withDuration: 0.3, animations: {
            // Hide cancel button
            self.cancelSearchButton.alpha = 0
        })
    }
    
}