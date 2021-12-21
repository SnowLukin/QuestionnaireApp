//
//  ResultViewController.swift
//  QuestionnaireApp
//
//  Created by Snow Lukin on 21.12.2021.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
        getResult()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        doneButton.setGreenGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ResultViewController {
    
    private func getResult() {
        let resultType = getMatchedAnimal(answers: answers)
        
        resultTitleLabel.text = "You are \(resultType.rawValue)!"
        resultDescriptionLabel.text = resultType.definition
    }
    
    private func setButton() {
        doneButton.setCustomContainerView()
    }
    
    private func getMatchedAnimal(answers: [Answer]) -> AnimalType {
        var animalTypes = [AnimalType]()
        
        for answer in answers {
            animalTypes.append(answer.type)
            print(answer.type)
        }
        
        let countedSetOfAnimalTypes = NSCountedSet(array: animalTypes)
        let mostFittableType = countedSetOfAnimalTypes.max {
            countedSetOfAnimalTypes.count(for: $0) < countedSetOfAnimalTypes.count(for: $1)
        } as! AnimalType
        
        return mostFittableType
    }
}
