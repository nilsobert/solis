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
    
    var questions = [Question(title: "In which year was the building constructed?", answers: ["Until 1960", "1961-1977", "1978-2010", "since 2011"], icon: UIImage.init(named: "houseIcon")!, id: 0), Question(title: "Does your building feature underground heating?", answers: ["Yes", "No"], icon: UIImage.init(named: "heatingIcon")!, id: 1), Question(title: "Does your building have solar panels?", answers: ["Yes", "No"], icon: UIImage.init(named: "solarPanelIcon")!, id: 2), Question(title: "What kind of glasses are built in?", answers: ["Single", "Double", "Triple"], icon: UIImage.init(named: "windowIcon")!, id: 3)]
    
    var result = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //corner radius
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 36
        backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}

extension CalculatorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as? QuestionsCollectionViewCell else { return QuestionsCollectionViewCell()}
        cell.questionLabel.text = questions[indexPath.row].title
        cell.iconLabel.image = questions[indexPath.row].icon
        
        
        
        
        if questions[indexPath.row].id == 1 || questions[indexPath.row].id == 2 {

            cell.answerButtonFour.isHidden = true
            cell.answerButtonThree.isHidden = true

            cell.labelOne.text = questions[indexPath.row].answers[0]
            cell.labelOne.text = questions[indexPath.row].answers[1]

        } else if questions[indexPath.row].id == 3 {

            cell.answerButtonFour.isHidden = true

            cell.labelOne.text = questions[indexPath.row].answers[0]
            cell.labelOne.text = questions[indexPath.row].answers[1]
            cell.labelOne.text = questions[indexPath.row].answers[2]
        } else {

            cell.labelOne.text = questions[indexPath.row].answers[0]
            cell.labelOne.text = questions[indexPath.row].answers[1]
            cell.labelOne.text = questions[indexPath.row].answers[2]
            cell.labelOne.text = questions[indexPath.row].answers[3]

        }
        
        return cell
    }
    
    
}
