//
//  CalculatorViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 18.11.22.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct Question {
        var title: String!
        var answers: [String]
        var icon: UIImage
        var id: Int
    }
    
    var questions = [Question(title: "In which year was the building constructed?", answers: ["Until 1960", "1961-1977", "1978-2010", "since 2011"], icon: UIImage.init(named: "")!, id: 0), Question(title: "Does your building feature underground heating?", answers: ["Yes", "No"], icon: UIImage.init(named: "")!, id: 1), Question(title: "Does your building have solar panels?", answers: ["Yes", "No"], icon: UIImage.init(named: "")!, id: 2), Question(title: "What kind of glasses are built in?", answers: ["Single", "Double", "Triple"], icon: UIImage.init(named: "")!, id: 3)]
    
    var result = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //corner radius
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 36
        backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        
    }
    
    

}

extension CalculatorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as? QuestionsCollectionViewCell else { return QuestionsCollectionViewCell()}
        cell.questionLabel.text = questions[indexPath.row].title
        
        
        
        cell.answerButtonOne.titleLabel?.text = questions[indexPath.row].answers[0]
        cell.answerButtonTwo.titleLabel?.text = questions[indexPath.row].answers[1]
        cell.answerButtonThree.titleLabel?.text = questions[indexPath.row].answers[2]
        //cell.answerButtonTwo.titleLabel?.text = "Answer 2"
        
        return cell
    }
    
    
}
