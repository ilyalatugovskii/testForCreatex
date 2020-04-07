//
//  TutorialPageViewController.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 04.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    
    private var controllers: Controllers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let firstVC = storyboard?.instantiateViewController(identifier: "first") as? FirstTutorialViewController else { return }
        guard let secondVC = storyboard?.instantiateViewController(identifier: "second") else { return }
       
        controllers = Controllers(vc: [firstVC, secondVC])
        firstVC.delegate = self

        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }


}

extension TutorialPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return controllers.prevViewController(currentVC: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return controllers.nextViewController(currentVC: viewController)
    }
    
}

extension TutorialPageViewController: ButtonPressDelegate {
    func nextPage(viewController: UIViewController) {
        
        self.delegate = self
        self.dataSource = self
        
        guard  let vc = controllers.nextViewController(currentVC: viewController) else { return }
        setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
}
