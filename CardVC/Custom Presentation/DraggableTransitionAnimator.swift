//
//  DraggableTransitionAnimator.swift
//  CardVC
//
//  Created by Salman Fakhri on 8/6/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import Foundation
import UIKit

class DraggableTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    private let vcToPresent: UIViewController
    private weak var presentingVC: UIViewController?
    
    init(viewControllerToPresent: UIViewController, presentingViewController: UIViewController) {
        vcToPresent = viewControllerToPresent
        presentingVC = presentingViewController
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        // initialize presentation controller here
        return DraggablePresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
