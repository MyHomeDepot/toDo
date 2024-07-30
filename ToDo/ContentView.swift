import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ListModel()
    @State var name = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.todos) { todo in
                    HStack {
                        Text(todo.name)
                        Spacer()
                        Button { viewModel.statusToggle(todo: todo)
                        } label: { Image(systemName: todo.isComplited ? "checkmark" : "square")
                        }
                    }
                }
                .onDelete(perform: viewModel.delete(index:))
                
                TextField("Add a new storie", text: $name)
                    .onSubmit {
                        viewModel.addItem(name: name)
                        name = ""
                    }
            }
            .navigationTitle("Stories")
        }
        
    }
}

#Preview {
    ContentView()
}
