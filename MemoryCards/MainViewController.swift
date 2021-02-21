//
//  MainViewController.swift
//  MemoryCards
//
//  Created by Alaattin Bulut Öztemur on 20.02.2021.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func openCategory2x3(_ sender: Any) {
        openGameBoard(x: 2, y: 3)
    }
    
    @IBAction func openCategory3x4(_ sender: Any) {
        openGameBoard(x: 3, y: 4)
    }
    
    @IBAction func openCategory4x6(_ sender: Any) {
        openGameBoard(x: 4, y: 6)
    }
    
    @IBAction func openCategory6x8(_ sender: Any) {
        openGameBoard(x: 6, y: 8)
    }
    
    func openGameBoard(x: Int, y: Int) {
        let gameBoardVC = GameBoardViewController(x: x, y: y)
        gameBoardVC.title = "GAME BOARD"
        navigationController?.pushViewController(gameBoardVC, animated: true)
    }
}
