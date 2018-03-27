//
//  GuessViewController.swift
//  Mind Flash
//
//  Created by Devan Allama on 3/19/18.
//  Copyright © 2018 Devan Allama. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var addQuestionButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    var colors = [#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 1, green: 0.7315711075, blue: 0.6788617961, alpha: 1), #colorLiteral(red: 0.8695150583, green: 0.2043739917, blue: 0.01309006226, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
    
    var questions = [Question]()
    
    var score = 0
    
    var displayedQuestion: Question?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addQuestionButton.layer.cornerRadius = 10
        addQuestionButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 10
        resetButton.clipsToBounds = true
        button1.layer.cornerRadius = 10
        button1.clipsToBounds = true
        button2.layer.cornerRadius = 10
        button2.clipsToBounds = true
        button3.layer.cornerRadius = 10
        button3.clipsToBounds = true
        button4.layer.cornerRadius = 10
        button4.clipsToBounds = true
        loadQuestions()
        generateQuestionText()
        scoreLabel.text = "Score = \(score)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadQuestions() {
        let question1 = Question(questionText: "What color is the sun?", answers: ["Yellow", "Blue", "Green", "Purple"], correctAnswer: 0)
        questions.append(question1)
    }
    
    func generateAnswerButtons(question: Question, colorSelection: [UIColor]) {
        var colorArray = colorSelection
        var questionAnswers = question.answers
        for i in 0...3 {
            let randomAnswer = Int(arc4random_uniform(UInt32(questionAnswers.count)))
            let randomColor = Int(arc4random_uniform(UInt32(colorArray.count)))
            switch i {
            case 0 :
                button1.setTitle(questionAnswers[randomAnswer], for: .normal)
                button1.backgroundColor = colorArray[randomColor]
            case 1:
                button2.setTitle(questionAnswers[randomAnswer], for: .normal)
                button2.backgroundColor = colorArray[randomColor]
            case 2:
                button3.setTitle(questionAnswers[randomAnswer], for: .normal)
                button3.backgroundColor = colorArray[randomColor]
            case 3:
                button4.setTitle(questionAnswers[randomAnswer], for: .normal)
                button4.backgroundColor = colorArray[randomColor]
            default:
                return
            }
            questionAnswers.remove(at: randomAnswer)
            colorArray.remove(at: randomColor)
        }
    }
    
    func generateQuestionText() {
        let randomQuestionIndex = Int(arc4random_uniform(UInt32(questions.count)))
        let currentQuestion = questions[randomQuestionIndex]
        questionLabel.text = currentQuestion.questionText
        displayedQuestion = questions[randomQuestionIndex]
        generateAnswerButtons(question: currentQuestion, colorSelection: colors )
        
        
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func answerButtonTapped(_ sender: Any) {
        let button = sender as! UIButton
        if button.titleLabel?.text == displayedQuestion?.answers[(displayedQuestion?.correctAnswer)!] {
            let alertView = UIAlertController(title: "Correct!", message: "You got the answer right, good job!", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Okay!", style: .default))
            self.present(alertView, animated: true, completion:nil)
        }
    }
    
    


}
