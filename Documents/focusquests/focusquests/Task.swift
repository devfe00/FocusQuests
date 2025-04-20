import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var estimatedMinutes: Int
    var isCompleted: Bool = false
    var completedDate: Date?

    func xpEarned() -> Int {
        return estimatedMinutes * 1
    }
}
