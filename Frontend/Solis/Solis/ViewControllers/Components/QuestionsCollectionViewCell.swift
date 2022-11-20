//
//  QuestionsCollectionViewCell.swift
//  Solis
//
//  Created by Julian Waluschyk on 19.11.22.
//

import UIKit

class QuestionsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var iconLabel: UIImageView!
    @IBOutlet weak var answerButtonOne: UIView!
    @IBOutlet weak var answerButtonTwo: UIView!
    @IBOutlet weak var answerButtonThree: UIView!
    @IBOutlet weak var answerButtonFour: UIView!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    
    override func awakeFromNib() {
        answerButtonOne.layer.cornerRadius = 18.0
        answerButtonOne.layer.masksToBounds = true
        
        answerButtonTwo.layer.cornerRadius = 18.0
        answerButtonTwo.layer.masksToBounds = true
        
        answerButtonThree.layer.cornerRadius = 18.0
        answerButtonThree.layer.masksToBounds = true
        
        answerButtonFour.layer.cornerRadius = 18.0
        answerButtonFour.layer.masksToBounds = true
    }
    
}
