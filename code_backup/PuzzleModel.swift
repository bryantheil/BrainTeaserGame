import Foundation

enum PuzzleType {
    case addition
    case multiplication
    case sequence
    case pattern
}

struct Puzzle {
    let question: String
    let answer: Int
    let type: PuzzleType
    let difficulty: Int // 1-5
}

class PuzzleGenerator {
    static func generatePuzzle(type: PuzzleType, difficulty: Int) -> Puzzle {
        switch type {
        case .addition:
            return generateAdditionPuzzle(difficulty: difficulty)
        case .multiplication:
            return generateMultiplicationPuzzle(difficulty: difficulty)
        case .sequence:
            return generateSequencePuzzle(difficulty: difficulty)
        case .pattern:
            return generatePatternPuzzle(difficulty: difficulty)
        }
    }
    
    private static func generateAdditionPuzzle(difficulty: Int) -> Puzzle {
        let num1 = Int.random(in: 10...100 * difficulty)
        let num2 = Int.random(in: 10...100 * difficulty)
        return Puzzle(
            question: "What is \(num1) + \(num2)?",
            answer: num1 + num2,
            type: .addition,
            difficulty: difficulty
        )
    }
    
    private static func generateMultiplicationPuzzle(difficulty: Int) -> Puzzle {
        let num1 = Int.random(in: 2...12)
        let num2 = Int.random(in: 2...12)
        return Puzzle(
            question: "What is \(num1) × \(num2)?",
            answer: num1 * num2,
            type: .multiplication,
            difficulty: difficulty
        )
    }
    
    private static func generateSequencePuzzle(difficulty: Int) -> Puzzle {
        let start = Int.random(in: 1...10)
        let step = Int.random(in: 2...5)
        let sequence = [start, start + step, start + step * 2]
        return Puzzle(
            question: "Complete the sequence: \(sequence[0]), \(sequence[1]), \(sequence[2]), ?",
            answer: start + step * 3,
            type: .sequence,
            difficulty: difficulty
        )
    }
    
    private static func generatePatternPuzzle(difficulty: Int) -> Puzzle {
        let base = Int.random(in: 2...5)
        let power = Int.random(in: 2...3)
        return Puzzle(
            question: "What is \(base) raised to the power of \(power)?",
            answer: Int(pow(Double(base), Double(power))),
            type: .pattern,
            difficulty: difficulty
        )
    }
} 