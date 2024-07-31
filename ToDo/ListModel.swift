import Foundation

let STATES = ["To do", "In progress", "Done"]

class ListModel: ObservableObject {
    @Published var todos: [ItemModel] = [ItemModel(name: "First job"), ItemModel(name: "Second job")]
    
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
    
    func delete(index: IndexSet) {
        todos.remove(atOffsets: index)
    }
}
