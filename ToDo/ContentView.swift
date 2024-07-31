import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ListModel()
    @State var name = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.todos) { todo in
                    Section {
                        VStack {
                            HStack {
                                Text(todo.name)
                                Spacer()
                                Button {
                                    viewModel.checkToggle(todo: todo)
                                } label: {
                                    Image(systemName: todo.isComplited ? "checkmark" : "square")
                                }
                            }
                            Picker("Current state", selection: Binding(
                                get: { todo.state },
                                set: { newState in
                                    viewModel.changeState(todo: todo, state: newState)
                                }
                            )) {
                                ForEach(STATES, id: \.self) { state in
                                    Text(state)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                }
                .onDelete(perform: viewModel.delete(index:))
                
                Section {
                    TextField("Add a new storie", text: $name)
                        .onSubmit {
                            viewModel.addItem(name: name)
                            name = ""
                        }
                }
            }
            .navigationTitle("Stories")
        }
    }
    
}

#Preview {
    ContentView()
}
