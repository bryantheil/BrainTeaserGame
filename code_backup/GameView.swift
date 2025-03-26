import SwiftUI

struct GameView: View {
    @State private var currentPuzzle: Puzzle?
    @State private var userAnswer: String = ""
    @State private var score: Int = 0
    @State private var difficulty: Int = 1
    @State private var showingResult = false
    @State private var isCorrect = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Brain Teaser")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Score: \(score)")
                    .font(.title2)
                    .foregroundColor(.primary)
                
                if let puzzle = currentPuzzle {
                    VStack(spacing: 15) {
                        Text(puzzle.question)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                        
                        TextField("Your answer", text: $userAnswer)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: checkAnswer) {
                            Text("Submit")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                } else {
                    Button(action: generateNewPuzzle) {
                        Text("Start New Puzzle")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Picker("Difficulty", selection: $difficulty) {
                    ForEach(1...5, id: \.self) { level in
                        Text("Level \(level)").tag(level)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
        }
        .alert(isPresented: $showingResult) {
            Alert(
                title: Text(isCorrect ? "Correct!" : "Try Again"),
                message: Text(isCorrect ? "Great job!" : "The correct answer was \(currentPuzzle?.answer ?? 0)"),
                dismissButton: .default(Text("OK")) {
                    if isCorrect {
                        generateNewPuzzle()
                    }
                }
            )
        }
    }
    
    private func generateNewPuzzle() {
        let types: [PuzzleType] = [.addition, .multiplication, .sequence, .pattern]
        let randomType = types.randomElement()!
        currentPuzzle = PuzzleGenerator.generatePuzzle(type: randomType, difficulty: difficulty)
        userAnswer = ""
    }
    
    private func checkAnswer() {
        guard let puzzle = currentPuzzle,
              let answer = Int(userAnswer) else { return }
        
        isCorrect = answer == puzzle.answer
        if isCorrect {
            score += difficulty * 10
        }
        
        showingResult = true
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
} 