import Foundation

struct TodoItem: Codable, Identifiable, Equatable {
    let id: UUID
    let content: String
    let createdAt: Date
    var isDone: Bool

    init(id: UUID = UUID(), content: String, createdAt: Date = Date(), isDone: Bool = false) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.isDone = isDone
    }
}
