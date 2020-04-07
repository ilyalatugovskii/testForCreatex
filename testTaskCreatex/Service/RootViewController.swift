//
//  RootViewController.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 06.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {

    private var currentVC: UIViewController
    
    init(current viewController: UIViewController) {
        currentVC = viewController
        super.init(nibName:  nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(currentVC)
        currentVC.view.frame = view.bounds
        view.addSubview(currentVC.view)
        currentVC.didMove(toParent: self)
    }
    
    func switchMainScreen(to feedViewController: UIViewController) {
        animateFadeTransition(to: feedViewController)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        currentVC.willMove(toParent: nil)
        addChild(new)
        
        transition(from: currentVC, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: nil) { [weak self] completed in
            self?.currentVC.removeFromParent()
            new.didMove(toParent: self)
            self?.currentVC = new
            completion?()
        }
    }
    
}
