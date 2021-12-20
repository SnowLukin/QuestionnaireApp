//
//  QuestionViewController.swift
//  QuestionnaireApp
//
//  Created by Snow Lukin on 20.12.2021.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var singleAnswerStackView: UIStackView!
    @IBOutlet weak var multipleAnswerStackView: UIStackView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet var singleAnswerButtons: [UIButton]!
    
    @IBOutlet var multipleAnswerLabels: [UILabel]!
    @IBOutlet var mulpitleAnswerSwitches: [UISwitch]!
    @IBOutlet var multipleAnswerViews: [UIView]!
    @IBOutlet weak var multipleAnswerButton: UIButton!
    
    
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answersChoosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setIBElements()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        multipleAnswerButton.setGreenGradient()
    }
    
    // MARK: - IBActions
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleAnswerButtons.firstIndex(of: sender) else { return }
        
        let currentAnswer = currentAnswers[buttonIndex]
        answersChoosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(mulpitleAnswerSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChoosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
}

extension QuestionViewController {
    
    private func setIBElements() {
        setContainerView()
        setButtons()
        setupUI()
        setMultipleAnswerContainerViews()
    }
    
    private func setContainerView() {
        containerView.layer.cornerRadius = 20
    }
    
    private func setButtons() {
        for button in singleAnswerButtons {
            button.backgroundColor = .white
            button.layer.cornerRadius = 12
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.systemGray.cgColor
        }
        
        multipleAnswerButton.layer.cornerRadius = 12
        multipleAnswerButton.layer.borderWidth = 2
        multipleAnswerButton.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    private func setMultipleAnswerContainerViews() {
        for view in multipleAnswerViews {
            view.layer.cornerRadius = 12
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.systemGray.cgColor
        }
    }
    
    private func setupUI() {
        for stackView in [singleAnswerStackView, multipleAnswerStackView] {
            stackView?.isHidden = true
        }
        
        let currentQuestion = questions[questionIndex]
        questionLabel.text = currentQuestion.title
        
//        let totalProgress = Float(questionIndex) / Float(questions.count)
//        questionProgressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .ranged:
            break
//           showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleAnswerStackView.isHidden = false
        
        for (button, answer) in zip(singleAnswerButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleAnswerStackView.isHidden = false
        
        for (lable, answer) in zip(multipleAnswerLabels, answers) {
            lable.text = answer.title
        }
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            setupUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
