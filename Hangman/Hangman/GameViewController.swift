//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var phrase : String!
    var phraseMatchTracker : [String]!
    var currentLetters : [String]!
    var mistakeLetters : [String]!
    var hangmanState : Int!

    @IBOutlet weak var submitTextField: UITextField!
    @IBOutlet weak var currentLettersLabel: UILabel!
    
    @IBOutlet weak var mistakeLettersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        generate()
        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /**
        sets up the game
    */
    func generate() {
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        currentLetters = []
        mistakeLetters = []
        phraseMatchTracker = []
        hangmanState = 1
        generateBlackSpaces()
    }
    
    /**
        Matches guessed characters with the word
    */
    func generateBlackSpaces() {
        
        
        
        for character in phrase.characters{
            if (character == " ") {
                phraseMatchTracker.append(" ")
                continue
            }
            if (currentLetters.contains(String(character))) {
                //If guessed letter matches with the phrase itll show that letter itself
                phraseMatchTracker.append(String(character))
            } else {
                phraseMatchTracker.append("_")
            }
        }
        currentLettersLabel.text! = phraseMatchTracker.joined(separator: ",");
    }
    
    
    @IBAction func startOverButtonPressed(_ sender: UIButton) {
        //Restarts the game
        generate()
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let submission : String! = submitTextField.text!
        
        
        if (submission.characters.count > 1) {
            //If too many characters in the textbox
            // create the alert
            let alert = UIAlertController(title: "Too many characters", message: "You can only submit one character at a time!", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        } else {
            if (phrase.characters.contains(Character(submission)) == false) {
                mistakeLetters.append(submission)
                hangmanState = hangmanState + 1
            }
        }
        
        generateBlackSpaces()
    }
    
    public func hangmanStateUpdate() {
        
    }
}
