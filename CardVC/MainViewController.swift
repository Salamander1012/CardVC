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
    var secondCardVC: TestCardVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        cardVC = CardVC(rootVC: self)
        
        cardVC?.view.backgroundColor = .lightGray
    }

}

