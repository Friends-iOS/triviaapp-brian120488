//
//  ViewController.swift
//  TriviaApp
//
//  Created by Adam Jackrel on 4/8/20.
//  Copyright © 2020 Adam Jackrel. All rights reserved.
//

//FEEDBACK:
//QUESTIONS - Very well researched, but no citations. Very important to cite your sources. Otherwise great work!
//DESIGN - Great, clean design. Easy to read and pleasing to the eye. However, you did not include an extra button (for reset, for example) and there was no score keeping.
//CODE - really excellent coding here. Love how you used a dictionary inside of the question array to easily parse and reference the answers. Line 247 is really excellent. Very compact and efficient coding. Very well thought out and very well researched. Its obvious you've put in the time to learn more about Swift. Its very worth it! Swift is a great intro to C/C++ languages and you'll see this kind of code in the future.
    //SOUND - It appears that the .mp3 file was not pushed along with everything else in the repo. I don't know why this happened, but to get the app to work, I had to remove all of the references to the sound playing. 
//GENERAL FEEDBACK: very excellent work, Brian. Not everything was included but your app really shows off your coding skills and your innovative thinking.

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet var allButtons: [UIButton]!
    
   // var player: AVAudioPlayer?
    
    var isLoading: Bool = false
    var correctNum: Int = 0
    var questionNum: Int = 0
    
    struct Question {
        var question: String
        var choices: [String: Bool]
        
        init(question: String, choices: [String: Bool]) {
            self.question = question
            self.choices = choices
        }
    }
    
    var questions: [Question] = [
        Question(question: "Each of the following statements is true, except:", choices: [
            "Viruses come in different types.": false,
            "Viruses infect other cells": false,
            "Viruses can replicate without hosts": true,
            "Viruses can cause illnesses": false
        ]),
        Question(question: "A virus infects a host in order to:", choices: [
            "Take in nutrients": false,
            "Make the host sick": false,
            "Make copies of itself": true,
            "Destroy the host's cells": false
        ]),
        Question(question: "The distinguishing feature of a coronavirus its:", choices: [
            "Size": false,
            "Mobility": false,
            "Shape": true,
            "Deadliness": false
        ]),
        Question(question: "A typical coronavirus infection:", choices: [
            "Is extremely dangerous": false,
            "Has mild symptoms": true,
            "Cannot spread to humans": false,
            "Is resistant to hand washing": false
        ]),
        Question(question: "Coronavirus infections are likely to be more serious for:", choices: [
            "Teens": false,
            "Active adults": false,
            "Frequent travelers": false,
            "People with weakened immune systems": true
        ]),
        Question(question: "An outbreak of a virus occurs when:", choices: [
            "Symptoms of the virus get worse": false,
            "The virus spreads to more than one organ": false,
            "Someone dies from the virus": false,
            "The virus spreads to more and more hosts": true
        ]),
        Question(question: "What does it mean when a city is quarantined during a virus outbreak?", choices: [
            "Everyone in the city is infected": false,
            "No one can enter or leave the city": true,
            "The city’s population is immune to the virus": false,
            "Doctors in the city are developing a cure": false
        ]),
        Question(question: "Which practice prevents the spread of germs?", choices: [
            "Washing your hands often": true,
            "Blowing your nose": false,
            "Reusing the same tissue": false,
            "Coughing into your hand": false
        ]),
        Question(question: "Covering your mouth when you cough or sneeze is recommended to:", choices: [
            "Prevent germs from entering your body": false,
            "Get rid of germs from inside your body": false,
            "Avoid getting other people sick": true,
            "Warn other people that you are sick": false
        ]),
        Question(question: "The most reliable source of information about virus outbreaks is:", choices: [
            "News headlines": false,
            "Social media": false,
            "Your peers": false,
            "The World Health Organization": true
        ]),
        Question(question: "About what percentage of infected people recover without needing hospital treatment?", choices: [
            "60%": false,
            "70%": false,
            "80%": true,
            "90%": false
        ]),
        Question(question: "Which of these is NOT listed by the WHO as a symptom of coronavirus?", choices: [
            "Fever": false,
            "Dry cough": false,
            "Blurred vision": true,
            "Nasal congestion": false
        ]),
        Question(question: "What does the 19 in Covid-19 stand for?", choices: [
            "It refers to the 19 molecules that make up the virus": false,
            "It is the 19th coronavirus identified": false,
            "It is the year the virus was first encountered: 2019": true,
            "It is its infection rate": false
        ]),
        Question(question: "What does the virus attach itself to when it enters the human body?", choices:  [
            "Antigens": false,
            "Red blood cells": false,
            "White blood cells": false,
            "Ace-2 receptors in the lining of the airways": true
        ]),
        Question(question: "How long can the virus survive on plastic and stainless steel surfaces?", choices: [
            "72 hours or more": true,
            "42 to 60 hours": false,
            "24 to 42 hours": false,
            "4 to 12 hours": false
        ]),
        Question(question: "Which organ in the body does the coronavirus primarily attack?", choices: [
            "Brain": false,
            "Lungs": true,
            "Liver": false,
            "Heart": false
        ]),
        Question(question: "Which of these is NOT a type of coronavirus?", choices: [
            "Ebola": true,
            "Sars": false,
            "229E": false,
            "Mers": false
        ]),
        Question(question: "What is the R number", choices: [
            "Percentage of confirmed cases that lead to death": false,
            "Percentage of population that has been tested": false,
            "Percentage of population that has NOT been tested": false,
            "Number of people one infected person passes on the virus": true,
        ]),
        Question(question: "What is a virus?", choices: [
            "A microscopic, single-celled organism": false,
            "An infection that replicates only inside other living cells": true,
            "A multicellular organism": false,
            "A organism that lives off other species": false
        ]),
        Question(question: "What is more effective at removing the coronavirus from your hands?", choices: [
            "Soap and water": true,
            "Alcohol-based hand sanitizer": false,
            "": false,
            " ": false
        ])
    ]
    
//    func playSound(name: String) {
//        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
//
//        do {
//                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//                try AVAudioSession.sharedInstance().setActive(true)
//
//                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
//                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//                /* iOS 10 and earlier require the following line:
//                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
//
//                guard let player = player else { return }
//
//                player.play()
//
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //player?.numberOfLoops = -1
       // playSound(name: "wii_music")
        //player?.numberOfLoops = -1
        for button in allButtons {
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 2
            button.layer.borderColor = #colorLiteral(red: 0.2631423473, green: 0.6635478735, blue: 0.7817897201, alpha: 1)
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.textAlignment = NSTextAlignment.center
        }
        
        changeQuestion()
        changeChoices()
    }

    @IBAction func choicePicked(_ sender: UIButton) {
        if(!isLoading) {
            //if choice wrong -> change button to red
            if(questions[questionNum].choices[(sender.titleLabel?.text)!] == false) {
                sender.backgroundColor = #colorLiteral(red: 0.9855045676, green: 0.007920332253, blue: 0.009584059939, alpha: 1)
            }
            else {
                correctNum += 1
            }
            
            //change correct button to green
            for button in allButtons {
                if(questions[questionNum].choices[(button.titleLabel?.text)!] == true) {
                    button.backgroundColor = #colorLiteral(red: 0.05852514505, green: 0.8538547754, blue: 0.07687816769, alpha: 1)
                }
            }
            
            isLoading = true
            _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
            
        }
    }

    @objc func updateUI(){
        resetColors()
        changeProgress()
        questionNum += 1
        if(questionNum < questions.count) {
            changeQuestion()
            changeChoices()
            isLoading = false
        }
        else {
            questionLabel.text = String(correctNum) + " out of " + String(questions.count) + " questions correct!"
            for button in allButtons {
                button.titleLabel?.text = ""
            }
        }
    }
    
    func changeQuestion() {
        questionLabel.text = questions[questionNum].question
    }
    func changeChoices() {
        for i in 0...3 {
            allButtons[i].setTitle(Array(questions[questionNum].choices.keys)[i], for: .normal)
        }
    }
    func resetColors() {
        for button in allButtons {
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func changeProgress() {
        progressBar.setProgress(progressBar.progress + (1.0 / Float(questions.count)), animated: true)
    }
}

