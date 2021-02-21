//
//  LoginViewController.swift
//  MemoryCards
//
//  Created by Alaattin Bulut Öztemur on 20.02.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func openMain(_ sender: Any) {
        let mainScreen = createTabBar()
        mainScreen.modalPresentationStyle = .fullScreen
        self.present(mainScreen, animated: false, completion: nil)
    }
    
    func createTabBar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemBlue
        tabbar.viewControllers = [createMainNavigationController(), createRecordsNavigationController(), createRecordsNavigationController(), createRecordsNavigationController(), createRecordsNavigationController()]
        return tabbar
    }
    
    func createMainNavigationController() -> UIViewController {
        let mainVC = MainViewController()
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: mainVC)
    }

    func createRecordsNavigationController() -> UINavigationController {
        let recordsVC = RecordsViewController()
        recordsVC.title = "Records"
        recordsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: recordsVC)
    }

    
}
