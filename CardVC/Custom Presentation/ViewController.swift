//
//  ViewController.swift
//  CardVC
//
//  Created by Salman Fakhri on 8/6/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var animator: DraggableTransitionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let cardVC = CardViewController()
        animator = DraggableTransitionDelegate(viewControllerToPresent: cardVC, presentingViewController: self)
        cardVC.transitioningDelegate = animator
        cardVC.modalPresentationStyle = .custom
        
        present(cardVC, animated: true) {
            print("completed Presentation")
        }
    }



}
