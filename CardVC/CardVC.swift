//
//  CardVC.swift
//  CardVC
//
//  Created by Salman Fakhri on 8/1/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

protocol CardViewController {
    var rootVC: UIViewController { get set }
    var topConstraint: NSLayoutConstraint? { get set }
    var height: CGFloat { get set }
    var topPosition: CGFloat { get set }
    var midPosition: CGFloat { get set }
    var bottomPosition: CGFloat { get set }
    var state: CardState { get set }
    var panGestureRecognizer: UIPanGestureRecognizer? { get set }
    var springAnimationTime: TimeInterval { get set }
    
    func setUpCardView()
}

enum CardState {
    case top
    case middle
    case bottom
}

class CardVC: UIViewController, CardViewController {
    var springAnimationTime: TimeInterval
    
    var panGestureRecognizer: UIPanGestureRecognizer?
    
    var state: CardState
    
    var rootVC: UIViewController
    
    var topConstraint: NSLayoutConstraint?
    
    var height: CGFloat
    
    var topPosition: CGFloat
    
    var midPosition: CGFloat
    
    var bottomPosition: CGFloat
    
    init(rootVC: UIViewController) {
        self.rootVC = rootVC
        self.height = rootVC.view.frame.height * 0.9
        self.topPosition = rootVC.view.frame.height * 0.1
        self.midPosition = rootVC.view.frame.height * 0.5
        self.bottomPosition = rootVC.view.frame.height * 0.9
        self.state = .middle
        self.springAnimationTime = 0.2
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCardView()
        setUpGestureRecognizers()
    }
    
    func setUpCardView() {
        rootVC.addChildViewController(self)
        rootVC.view.addSubview(view)
        let rootView = rootVC.view
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: (rootView?.leftAnchor)!).isActive = true
        view.rightAnchor.constraint(equalTo: (rootView?.rightAnchor)!).isActive = true
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        topConstraint = view.topAnchor.constraint(equalTo: (rootView?.topAnchor)!, constant: midPosition)
        topConstraint?.isActive = true
    }
}

// MARK:- Gestures
extension CardVC {
    func setUpGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        view.addGestureRecognizer(panGestureRecognizer)
        self.panGestureRecognizer = panGestureRecognizer
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        if let view = gesture.view {
            if let currentTopConstant = topConstraint?.constant {
                if translation.y < 0 {
                    topConstraint?.constant = currentTopConstant>(topPosition) ? currentTopConstant + translation.y : currentTopConstant
                } else {
                    topConstraint?.constant = (currentTopConstant<bottomPosition) ? currentTopConstant + translation.y : currentTopConstant
                }
            }
        }
        gesture.setTranslation(CGPoint.zero, in: self.view)

        if gesture.state == .ended {
            if velocity.y < -500 {
                //move up
                swipedUp()
                state = .top
            } else if velocity.y > 500 {
                //move down
                swipedDown()
            } else {
                //move to closest position
                if let topConstant = topConstraint?.constant {
                    let closestPosition = findClosestPosition(to: topConstant)
                    switch closestPosition {
                    case .bottom:
                        moveViewTop(toPostion: bottomPosition)
                        state = .bottom
                    case .middle:
                        moveViewTop(toPostion: midPosition)
                        state = .middle
                    case .top:
                        moveViewTop(toPostion: topPosition)
                        state = .top
                    }
                }
            }
        }
    }
//
    func moveViewTop(toPostion position: CGFloat) {
        
        UIView.animate(withDuration: self.springAnimationTime ?? 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.topConstraint?.constant = position
            self.rootVC.view.layoutIfNeeded()
        })
    }
    
    func findClosestPosition(to currentPosition: CGFloat) -> CardState {
        let bottomDiff = abs(currentPosition - bottomPosition)
        let midDiff = abs(currentPosition - midPosition)
        let topDiff = abs(currentPosition - topPosition)
        
        let minVal = min(bottomDiff, midDiff, topDiff)
        if minVal == bottomDiff {
            return .bottom
        } else if minVal == midDiff {
            return .middle
        } else {
            return .top
        }
    }
    
    func swipedUp() {
        switch state {
        case .bottom:
            moveViewTop(toPostion: midPosition)
            state = .middle
        case .middle:
            moveViewTop(toPostion: topPosition)
            state = .top
        case .top:
            moveViewTop(toPostion: topPosition)
            state = .top
        }
    }
    
    func swipedDown() {
        switch state {
        case .bottom:
            moveViewTop(toPostion: bottomPosition)
            state = .bottom
        case .middle:
            moveViewTop(toPostion: bottomPosition)
            state = .bottom
        case .top:
            moveViewTop(toPostion: midPosition)
            state = .middle
        }
    }
}










