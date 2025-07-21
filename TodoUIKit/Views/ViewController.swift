import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    private var todos: [TodoItem] = []

    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy.MM.dd HH:mm"
        return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        todos = UserDefaults.standard.loadTodos()
    }

    @IBAction func addTodo(_ sender: UIButton) {
        guard let trimmed = inputField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmed.isEmpty else { return }

        todos.append(TodoItem(content: trimmed))
        inputField.text = ""
        saveTodos()
        tableView.reloadData()
    }

    private func saveTodos() {
        UserDefaults.standard.saveTodos(todos)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = todos[indexPath.row]
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: todo.isDone ? NSUnderlineStyle.single.rawValue : 0,
            .foregroundColor: todo.isDone ? UIColor.secondaryLabel : UIColor.label
        ]

        cell.textLabel?.attributedText = NSAttributedString(
            string: todo.content,
            attributes: attributes
        )
        cell.detailTextLabel?.attributedText = NSAttributedString(
            string: dateFormatter.string(from: todo.createdAt),
            attributes: attributes
        )
        cell.accessoryType = todo.isDone ? .checkmark : .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todos[indexPath.row].isDone.toggle()
        saveTodos()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todos.remove(at: indexPath.row)
        saveTodos()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
