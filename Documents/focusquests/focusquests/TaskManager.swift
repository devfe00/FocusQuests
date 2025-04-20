import Foundation
import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var totalXP: Int = 0
    @Published var level: Int = 1
    @Published var justLeveledUp: Bool = false

    var currentXPPercentage: Double {
        let currentLevelXP = Double(totalXP % 100)
        return currentLevelXP / 100
    }

    func addTask(title: String, estimatedMinutes: Int) {
        let newTask = Task(title: title, estimatedMinutes: estimatedMinutes)
        tasks.append(newTask)
    }

    func completeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
            tasks[index].completedDate = Date()
            totalXP += task.xpEarned()
            checkLevelUp()
        }
    }

    private func checkLevelUp() {
        let oldLevel = level
        level = totalXP / 100

        if level > oldLevel {
            justLeveledUp = true

            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.justLeveledUp = false
            }
        }
    }
}
