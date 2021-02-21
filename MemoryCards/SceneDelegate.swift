//
//  SceneDelegate.swift
//  MemoryCards
//
//  Created by Alaattin Bulut Öztemur on 20.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
    }
    
    func createMainNavigationController() -> UIViewController {
        // we create the view controller and insert into the nav controller and return
        let mainVC = MainViewController()
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return mainVC
        /*mainVC.title = "Play"
        // it is a system tabbaritem , tag zero because it is the first one
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: mainVC) */
    }

    func createRecordsNavigationController() -> UINavigationController {
        let recordsVC = RecordsViewController()
        recordsVC.title = "Records"
        // it is a system tabbaritem , tag zero because it is the first one
        recordsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: recordsVC)
    }

    func createTabBar() -> UITabBarController {
        let tabbar = UITabBarController()
        // here we assign a tint to all our tabbars, this will be visible on the items (icons)
        UITabBar.appearance().tintColor = .systemBlue
        // replace our array variables with the functions we created
        tabbar.viewControllers = [createMainNavigationController(), createRecordsNavigationController(), createRecordsNavigationController(), createRecordsNavigationController(), createRecordsNavigationController()]
        return tabbar
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

