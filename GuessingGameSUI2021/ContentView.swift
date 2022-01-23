//
//  ContentView.swift
//  GuessingGameSUI2021
//
//  Created by Amit Gupta on 12/5/21.
//

import SwiftUI

var numberToGuess=0
var lowRange=0
var highRange=100
var totalGuesses=10
var guessesUsed=0

struct ContentView: View {
    @State var gameName="Guessing Game"
    @State var topText=""
    @State var guessCountLabel=""
    @State var nextGuess=""
    @State var butttonLabel="Submit"
    @State var gameOn=true
    
    var body: some View {
        VStack (alignment: .center) {
            Text(gameName)
                .font(.system(size: 40))
            Spacer()
            Text(topText)
                .font(.system(size: 30))
            Text(guessCountLabel)
                .font(.system(size: 20))
            Spacer()
            TextField("Next guess",text:$nextGuess)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
            Button(butttonLabel) {
                if(gameOn) {
                if let l = Int(nextGuess) {
                    processGuess(l)
                }
                } else {
                    initializeGame()
                }
            }
            .font(.system(size:40))
            .padding()
            .background(.yellow)
            .clipShape(Capsule())
            Spacer()
        }
        .onAppear(perform: initializeGame)
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity)
        .font(.system(size: 40))
        
    }
    
    
    
    /**
     * Core Swift code for processing user input
     */
    
    func generateRandomNumber() {
        numberToGuess = Int.random(in: lowRange ... highRange)
        print("Generated random number:",numberToGuess)
    }
    
    func initializeGame() {
        generateRandomNumber()
        lowRange=0
        highRange=100
        totalGuesses=10
        guessesUsed=0
        topText="Guess x\n \(lowRange) < x < \(highRange)"
        guessCountLabel=""
        nextGuess=""
        butttonLabel="Submit"
        gameOn=true
    }
    
    func processGuess(_ guessedNumber: Int) {
        guessesUsed += 1
        print("Just saw new guess:",guessedNumber," vs. numberToGuess=",numberToGuess)
        if(guessedNumber == numberToGuess) {
            processMatch()
            return
        } else {
            if(guessesUsed>=totalGuesses) {
                processNoMatch()
            }
            if(guessedNumber<numberToGuess) { // Too low
                if(guessedNumber>lowRange) {
                    lowRange=guessedNumber
                }
            } else { // Too high
                if(guessedNumber<highRange) {
                    highRange=guessedNumber
                }
            }
            updateGuessInformation()
        }
        return
    }
    
    func processMatch() {
        print("MATCHED!!")
        gameOn=false
         let successMsg=String(format:"You correctly guessed %d in %d tries",numberToGuess,guessesUsed)
         topText=successMsg
         nextGuess=""
         guessCountLabel=""
        butttonLabel="Well done!!"
    }
    
    func processNoMatch() {
        print("NOT MATCHED!!")
        gameOn=false
         let successMsg=String(format:"Sorry - the number was %d",numberToGuess)
         topText=successMsg
         nextGuess=""
         guessCountLabel=""
         butttonLabel="Better luck next time!!"
    }
    
    func updateGuessInformation() {
         guessCountLabel=String(format:"Tries remaining: %d",totalGuesses-guessesUsed)
         topText=String(format:"What is X? \n \(lowRange) < x < \(highRange)")
        nextGuess=""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
