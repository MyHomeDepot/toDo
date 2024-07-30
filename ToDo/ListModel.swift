import Foundation

class ListModel: ObservableObject {
    @Published var todos: [ItemModel] = [ItemModel(name: "First job"), ItemModel(name: "Second job")]
    
    func addItem(name: String) {
        todos.append(ItemModel(name: name))
    }
    
    func statusToggle(todo: ItemModel) {
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].isComplited.toggle()
    }
    
    func delete(index: IndexSet) {
        todos.remove(atOffsets: index)
    }
}
