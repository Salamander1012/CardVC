//
//  ViewController.swift
//  CardVC
//
//  Created by Salman Fakhri on 8/1/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var cardVC: CardVC?
    var secondCardVC: CardVC?
    var testVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        cardVC = CardVC(rootVC: self)
        cardVC?.delegate = self
        cardVC?.view.backgroundColor = .lightGray
        
        addRootLabel()
        addChildLabel()
        
        
    }
    
    func addRootLabel() {
        let rootLabel = UILabel()
        rootLabel.text = "Root View Controller"
        rootLabel.textColor = .black
        view.addSubview(rootLabel)
        rootLabel.translatesAutoresizingMaskIntoConstraints = false
        rootLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rootLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
    }
    
    func addChildLabel() {
        let childLabel = UILabel()
        childLabel.text = "CardVC"
        childLabel.textColor = .black
        cardVC?.view.addSubview(childLabel)
        if let childView = cardVC?.view {
            childLabel.translatesAutoresizingMaskIntoConstraints = false
            childLabel.centerXAnchor.constraint(equalTo: childView.centerXAnchor).isActive = true
            childLabel.topAnchor.constraint(equalTo: childView.topAnchor, constant: 30).isActive = true
        }
        
    }
    
}

extension MainViewController: CardVCDelegate {
    func cardViewDidLoad(cardView: UIView) {
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
    }
}

