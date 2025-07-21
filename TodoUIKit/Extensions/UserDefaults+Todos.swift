import Foundation

extension UserDefaults {
    private static let todosKey = "todos"

    func loadTodos() -> [TodoItem] {
        if let data = data(forKey: Self.todosKey),
           let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) {
            return decoded
        }
        return []
    }

    func saveTodos(_ todos: [TodoItem]) {
        if let encoded = try? JSONEncoder().encode(todos) {
            set(encoded, forKey: Self.todosKey)
        }
    }
}
