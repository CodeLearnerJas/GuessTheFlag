//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by GuitarLearnerJas on 14/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var finalScore = 0
    @State private var currentRound = 1
    @State private var shouldReset = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color.blue.opacity(0.5), location: 0.1),
                .init(color: Color.red.opacity(0.3), location: 1)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guest The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 30){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.black)
                    }
                    
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial.opacity(0.7))
                .clipShape(.rect(cornerRadius: 30))
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Text("Current Round: \(currentRound) / 8")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
        }
        
        //Normal response to question
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Play Again") {
                askQuestion()
                currentRound += 1
                resetGame()
            }
        } message: {
            Text("Nice! +1 Score!")
        }
        //Final scoreboard
        .alert(scoreTitle, isPresented: $shouldReset) {
            HStack{
                Button("Start A New Game!") {
                    resetGame()
                }
                Button("Cancell", role: .cancel) {}
            }
        } message: {
            Text("8 Games in!\n Your Score is \(finalScore).")
        }
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer{
            scoreTitle = "You Got It!"
            score += 1
        } else {
            scoreTitle = "Try Again! \nThe Flag you selected was \(countries[number])."
            score += 0
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        if currentRound > 8 {
            shouldReset = true
            scoreTitle = "8 Games in!"
            currentRound = 1
            finalScore = score
            score = 0
        }
    }
}

#Preview {
    ContentView()
}
