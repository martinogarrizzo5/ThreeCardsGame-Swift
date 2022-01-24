//
//  ViewController.swift
//  ThreeCardGame
//
//  Created by Martin on 18/01/22.
//

import UIKit

class ViewController: UIViewController {

	// outlets
	@IBOutlet var cardsButtons: [UIButton]!
	@IBOutlet weak var lifeLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var lifeLostLabel: UILabel!
	@IBOutlet weak var dialogView: UIView!
	@IBOutlet weak var totalScoreLabel: UILabel!
	@IBOutlet weak var maxScoreLabel: UILabel!
	@IBOutlet weak var backScreen: UIView!
	@IBOutlet weak var restartButton: UIButton!
	@IBOutlet weak var gameOverLabel: UILabel!
	
	// images
	var spadesAceImage = #imageLiteral(resourceName: "picche")
	var heartsAceImage = #imageLiteral(resourceName: "cuori")
	var backCardImage = #imageLiteral(resourceName: "back")
	
	// props
	var lives: Int = 5
	let maxLives: Int = 5
	var score: Int = 0
	var maxScore: Int = 0
	var isCardClicked: Bool = false
	var isGameOver: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// setup UI
		lifeLabel.text = String(lives)
		scoreLabel.text = "Score: \(score)"
		gameOverLabel.font = UIFont(name: "Ultra", size: 32)
		restartButton.titleLabel?.font = UIFont(
			name: "TitanOne", size: 32)
		lifeLostLabel.alpha = 0
		backScreen.isHidden = true
		dialogView.layer.cornerRadius = 25
		dialogView.isHidden = true
		restartButton.layer.cornerRadius = 36
		// set border radius of cards
		for card in cardsButtons {
			card.layer.cornerRadius = 10
		}
		
		// ensure cards are covered
		for card in cardsButtons {
			card.setImage(backCardImage, for: .normal)
		}
	}
	
	@IBAction func playRound(_ sender: UIButton) {
		// don't play new rounds if game is over
		if isGameOver {
			return
		}
		
		// allow player to click only one card for round
		if !isCardClicked {
			// prevent user from clicking other cards
			isCardClicked = true;
			
			let heartsCardIndex: Int = chooseHeartIndex()
			revealCards(heartsCardIndex: heartsCardIndex)
			
			handleRoundResult(heartsCard: cardsButtons[heartsCardIndex], clickedCard: sender)
			
			// play new round after delay
			let delay: Double = 1.0
			DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
				self.playNewRound()
			}
		}
	}
	
	// random selection of the hearts card index
	func chooseHeartIndex() -> Int {
		let heartsCardIndex: Int = .random(in: 0..<cardsButtons.count)
		
		return heartsCardIndex
	}
	
	// reveal cards
	func revealCards(heartsCardIndex: Int) -> Void {
		// display the three cards
		for i in 0..<cardsButtons.count {
			if i == heartsCardIndex {
				cardsButtons[i].setImage(heartsAceImage, for: .normal)
			} else {
				cardsButtons[i].setImage(spadesAceImage, for: .normal)
			}
		}
	}
	
	func handleRoundResult(heartsCard: UIButton, clickedCard: UIButton) -> Void {
		// victory
		if heartsCard == clickedCard {
			score += 250
			scoreLabel.text = "Score: \(score)"
		}
		// defeat
		else {
			lives -= 1
			lifeLabel.text = String(lives)
			warnLifeLost()
			
			if lives <= 0 {
				endGame()
			}
		}
	}
	
	func restoreCards() -> Void {
		for card in cardsButtons {
			// card disappear
			card.alpha = 0
			
			// cover the card
			card.setImage(backCardImage, for: .normal)
			
			// card reappear
			UIView.animate(withDuration: 0.3, animations: { card.alpha = 1 }, completion: { finished in
				self.restoreUserInteraction()
			})
			
		}
	}
	
	func playNewRound() -> Void {
		restoreCards()
	}
	
	func restoreUserInteraction() -> Void {
		isCardClicked = false;
	}

	func warnLifeLost() -> Void {
		lifeLostLabel.alpha = 1
		
		UIView.animate(withDuration: 0.8, animations: { self.lifeLostLabel.alpha = 0
		})
		
	}
	
	func endGame() -> Void {
		totalScoreLabel.text = "Total Score: \(score)"
		
		if score > maxScore {
			maxScoreLabel.text = "New record!"
			maxScore = score
		} else {
			maxScoreLabel.text = "Max Score: \(maxScore)"
		}
		
		isGameOver = true
		showEndGameScreen()
	}
	
	func showEndGameScreen() -> Void {
		dialogView.isHidden = false
		backScreen.isHidden = false
	}
	
	func resetUI() -> Void {
		dialogView.isHidden = true
		backScreen.isHidden = true
		scoreLabel.text = "Score: 0"
		lifeLabel.text = String(maxLives)
	}
	
	@IBAction func restartGame(_ sender: UIButton) {
		isGameOver = false
		resetUI()
		score = 0
		lives = maxLives
	}
}
