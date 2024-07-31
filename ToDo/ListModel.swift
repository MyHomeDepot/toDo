import Foundation

let STATES = ["To do", "In progress", "Done"]

class ListModel: ObservableObject {
    @Published var todos: [ItemModel] = []
    
    func addItem(name: String) {
        todos.append(ItemModel(name: name))
    }
    
    func checkToggle(todo: ItemModel) {
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].isComplited.toggle()
    }
    
    func changeState(todo: ItemModel, state: String) {
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].state = state
    }
    
    func taskCounter() -> String {
        let count = todos.count
        
        switch count {
        case 0:
            return "Your list is empty. \nYou can add a task below."
        case 1:
            return "You have \(count) task"
        default:
            return "You have \(count) tasks"
        }
    }
    
    func stateCounter(state: String) -> Int {
        var count = 0
        
        for todo in todos {
            if todo.state == state {
                count += 1
            }
        }
        return count
    }
    
    func delete(index: IndexSet) {
        todos.remove(atOffsets: index)
    }
}
