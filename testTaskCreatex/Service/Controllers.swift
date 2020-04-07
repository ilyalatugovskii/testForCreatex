
//
//  Controllers.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 06.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation
import UIKit

class Controllers {
    private var viewControllers: [UIViewController]?
    
    init(vc: [UIViewController]) {
        viewControllers = vc
    }
    
    func nextViewController(currentVC: UIViewController) -> UIViewController? {
        
        if currentVC == viewControllers?.last {
            return nil
        }
        
        guard let index = viewControllers?.firstIndex(where: { currentVC == $0}) else { return nil }
        
        let vc = viewControllers?[index + 1]
        return vc
    }
    
    func prevViewController(currentVC: UIViewController) -> UIViewController? {
        
        if currentVC == viewControllers?.first {
            return nil
        }
        
        guard let index = viewControllers?.firstIndex(where: { currentVC == $0}) else { return nil }
        let vc = viewControllers?[index - 1]
        return vc
    }
    
}
