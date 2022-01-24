//
//  GameMenuViewController.swift
//  ThreeCardGame
//
//  Created by Martin on 21/01/22.
//

import UIKit

class GameMenuViewController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var startButton: UIButton!
	
	@IBOutlet weak var card1: UIButton!
	@IBOutlet weak var card3: UIButton!
	@IBOutlet weak var card2: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		titleLabel.font = UIFont(name: "Ultra", size: 62)
		
		startButton.layer.cornerRadius = 36
		startButton.titleLabel?.font = UIFont(
			name: "TitanOne", size:32)
		
		card1.transform = CGAffineTransform(rotationAngle: -0.66)
		
		card2.transform = CGAffineTransform(rotationAngle: 2.3)
		
		card3.transform = CGAffineTransform(rotationAngle: 0.26)
    }

}
