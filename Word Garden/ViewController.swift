//
//  ViewController.swift
//  Word Garden
//
//  Created by Morgan Glover on 9/15/19.
//  Copyright © 2019 Morgan Glover. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        //print("In viewDidLoad, is guessedLetterField the first responder?", guessedLetterField.isFirstResponder)
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord = revealedWord + " \("_")"
            }
        }
        revealedWord.removeFirst()
        print("Revealed Word is currently: \(revealedWord)")
        
        userGuessLabel.text = revealedWord
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        //decrements the wrongGuessesRemaining and shows the next flower image with one less pedal
        let currentLetterGuessed = guessedLetterField.text!
        print("Current Letter Guessed: \(currentLetterGuessed)")
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        print("Wrong Guesses Remaining: \(wrongGuessesRemaining)")
        
        let revealedWord = userGuessLabel.text!
        //stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "Sorry, you're out of guesses! Try again?"
        } else if !revealedWord.contains("_") {
            guessCountLabel.text = "You've won the game! It took you \(guessCount) guesses to guess the word!"
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
        } else {
            let guess = (guessCount == 1 ? "Guess" : "Guesses")
//            var guess = "guesses"
//            if guessCount == 1 {
//                guess = "guess"
//            }
            guessCountLabel.text = "You've Made \(guessCount) \(guess)!"
        }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        //print("Hey! The guessedLetterFieldChanged!")
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            //disable button if no single character in guessedLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        //print("In doneKeyPressed, is guessedLetterField the first responder before updateUIAfterGuess?", guessedLetterField.isFirstResponder)
        guessALetter()
        updateUIAfterGuess()
        //print("In doneKeyPressed, is guessedLetterField the first responder after updateUIAfterGuess??", guessedLetterField.isFirstResponder)
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        //print("In guessLetterButton, is guessedLetterField the first responder before updateUIAfterGuess??", guessedLetterField.isFirstResponder)
        guessALetter()
        updateUIAfterGuess()
        //print("In guessLetterButton, is guessedLetterField the first responder after updateUIAfterGuess??", guessedLetterField.isFirstResponder)
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses!"
        guessCount = 0
    }
    
}

