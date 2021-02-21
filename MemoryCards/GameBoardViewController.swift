//
//  GameBoardViewController.swift
//  MemoryCards
//
//  Created by Alaattin Bulut Öztemur on 21.02.2021.
//

import UIKit

class GameBoardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var matchedLabel: UILabel!
    
    let model = CardModel()
    var cardsArray = [Card]()
    var firstFlippedCardIndex: IndexPath?
    var timer: Timer?
    var milliseconds: Int = 10 * 1000
    let screenWidth = UIScreen.main.bounds.size.width
    
    let categoryX: Int?
    let categoryY: Int?
    var matchCount: Int = 0
    
    init(x: Int, y: Int) {
        categoryX = x
        categoryY = y
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        cardsArray = model.getCards(numOfCards: categoryX! * categoryY! / 2)
        
        // Set the view controller as the datasource and delegete of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.updateMatchedLabel()
        self.navigationItem.leftBarButtonItem = createLeftBarButton()
        // Initialize the timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func createLeftBarButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.reply, target: self, action: #selector(showConfirmationAlert))
    }

    @objc func timerFired() {
        // Decrement the counter
        milliseconds -= 1
        
        // Update the label
        let seconds: Double = Double(milliseconds) / 1000.0
        timerLabel.text = String(format: "Time Remaining: %.2f", seconds)
        
        // Stop the timer if it reachs zero
        if milliseconds == 0 {
            timerLabel.textColor = UIColor.red
            timer?.invalidate()
            
            // Check if the user has cleared all pairs
            checkForGameEnd()
        }
    }

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = ((screenWidth - 30) - ((CGFloat(categoryX!) - 1) * 10)) / CGFloat(categoryX!)
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
 
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let card = cardsArray[indexPath.row]
        // Finish configuring the cell
        (cell as? CardCollectionViewCell)?.configureCell(card: card)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get a reference to the cell that was tapped
        // We are not sure that given indexPath returns type CardCollectionViewCell. So we use "as?". Cell could be nil.
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Check the status of the card to determine how to flip it
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            cell?.flipUp()
            
            // check the first card that was flipped or the second card
            if firstFlippedCardIndex == nil {
                // This is the first card flipped over
                firstFlippedCardIndex = indexPath
                
            } else {
                // Second card that is flipped
                // Run the comparison logic
                checkForMatch(indexPath)
            }
        }
    }
    
    func checkForMatch(_ secondFlippedCardIndex: IndexPath) {
        
        // Get the  two card objects for the two indices and see if they match
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        // Get the two collection view cells that represent card one and two
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            // It's a match
            // Set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            self.matchCount += 1
            self.updateMatchedLabel()
            // Was that the last pair?
            checkForGameEnd()
            
        } else {
            // It's not a match
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip them back over
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }
    
    func checkForGameEnd() {
        
        // Check if there is any card that is unmatched
        var hasWon = true
        for card in cardsArray {
            if card.isMatched == false {
                hasWon = false
                break
            }
        }
        
        if hasWon {
            // User has won, show an alert
            showAlert(title: "Congratulations", message: "You've won the game!")
        } else {
            // User hasn't won yet, check if there's any time left
            if milliseconds <= 0 {
                showAlert(title: "Time's Up", message: "Sorry, better luck next time!")
                collectionView.isUserInteractionEnabled = false
                //NOT WORK : collectionView.visibleCells.forEach {$0.isUserInteractionEnabled = false}
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showConfirmationAlert() {
        if(matchCount == categoryX! * categoryY!) {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to quit?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "YES", style: .default){_ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            let noAction = UIAlertAction(title: "NO", style: .default, handler: nil)

            alert.addAction(okAction)
            alert.addAction(noAction)

            present(alert, animated: true, completion: nil)
        }
    }

    
    func updateMatchedLabel(){
        self.matchedLabel.text = "Matched: \(matchCount)/\(categoryX! * categoryY! / 2)"
    }
}
