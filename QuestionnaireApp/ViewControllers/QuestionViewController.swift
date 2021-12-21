//
//  QuestionViewController.swift
//  QuestionnaireApp
//
//  Created by Snow Lukin on 20.12.2021.
//

import UIKit

class QuestionViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var singleAnswerStackView: UIStackView!
    @IBOutlet weak var multipleAnswerStackView: UIStackView!
    @IBOutlet weak var rangeAnswerStackView: UIStackView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet var singleAnswerButtons: [UIButton]!
    
    @IBOutlet var multipleAnswerLabels: [UILabel]!
    @IBOutlet var mulpitleAnswerSwitches: [UISwitch]!
    @IBOutlet var multipleAnswerViews: [UIView]!
    @IBOutlet weak var multipleAnswerButton: UIButton!
    
    @IBOutlet weak var rangeAnswerSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            
            rangeAnswerSlider.maximumValue = answerCount
            rangeAnswerSlider.value = answerCount / 2
        }
    }
    @IBOutlet var rangeAnswerLabels: [UILabel]!
    @IBOutlet weak var rangeAnswerButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    // MARK: Private Properties
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answersChoosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setIBElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        multipleAnswerButton.setGreenGradient()
        rangeAnswerButton.setGreenGradient()
    }
    
    // MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! ResultViewController
        resultVC.answers = answersChoosen
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    @IBAction func rangeAnswerButtonPressed() {
        let index = lrintf(rangeAnswerSlider.value)
        answersChoosen.append(currentAnswers[index])
        
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
        containerView.layer.cornerRadius = 30
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setButtons() {
        for button in singleAnswerButtons {
            button.setCustomContainerView()
        }
        
        multipleAnswerButton.setCustomContainerView()
        rangeAnswerButton.setCustomContainerView()
    }
    
    private func setMultipleAnswerContainerViews() {
        for view in multipleAnswerViews {
            view.setCustomContainerView()
        }
    }
    
    private func setupUI() {
        for stackView in [singleAnswerStackView, multipleAnswerStackView, rangeAnswerStackView] {
            stackView?.isHidden = true
        }
        
        let currentQuestion = questions[questionIndex]
        questionLabel.text = currentQuestion.title
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        progressBar.setProgress(totalProgress, animated: true)
        
        title = "Question \(questionIndex + 1) / \(questions.count)"
        
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .ranged:
           showRangedStackView(with: currentAnswers)
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
    
    private func showRangedStackView(with answers: [Answer]) {
        rangeAnswerStackView.isHidden = false
        
        rangeAnswerLabels.first?.text = answers.first?.title
        rangeAnswerLabels.last?.text = answers.last?.title
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
