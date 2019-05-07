//
//  PageViewController.swift
//  NewYorkTimes
//
//  Created by Win on 5/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDelegate {

    lazy var pages: [UIViewController] =  self.getViewControllers(withIdentifier: ID.pageContentId.rawValue)
    
    var detailPageList:[String] = []
    var indexPage : (String,Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let selectVC = self.pages[(indexPage?.1)!]
        self.setViewControllers([selectVC], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate   = self
    }
    
    
    @IBAction func goBackHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func getViewControllers(withIdentifier identifier: String) -> [UIViewController]
    {
        let mutableArray = NSMutableArray()
        var index = 1
        for pageURL in self.detailPageList {
            if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: identifier) as?
                PageContentViewController {
                pageContentViewController.webURL = pageURL
                
                mutableArray.add(pageContentViewController)
                index = index + 1
            }
        }
        return (mutableArray as? [UIViewController])!
    }
    
    var currentIndex:Int {
        get {
            return pages.index(of: self.viewControllers!.first!)!
        }
        
        set {
            guard newValue >= 0,
                newValue < pages.count else {
                    return
            }
            
            let vc = pages[newValue]
            let direction:UIPageViewController.NavigationDirection = newValue > currentIndex ? .forward : .reverse
            self.setViewControllers([vc], direction: direction, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
    }
}

extension PageViewController:UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let nextIndex = currentIndex + 1
        
        guard pages.count != nextIndex else {
            return nil
        }
        
        guard pages.count > nextIndex else {
            return nil
        }
        return pages[nextIndex]
    }
    
    // The number of items reflected in the page indicator.
    public func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return pages.count
    }
    
    // The selected item reflected in the page indicator.
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = self.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
        
    }
    
    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = self.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
    }

}
