import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ListModel()
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack {
                        HStack {
                            Spacer()
                            Text("\(viewModel.taskCounter())")
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        
                        if viewModel.todos.count != 0 {
                            Spacer()
                            HStack {
                                Text("To do - \(viewModel.stateCounter(state: "To do"))")
                                Spacer()
                                Text("In progress - \(viewModel.stateCounter(state: "In progress"))")
                            }
                            HStack {
                                Text("Done - \(viewModel.stateCounter(state: "Done"))")
                                Spacer()
                                Text("Not process - \(viewModel.stateCounter(state: ""))")
                            }
                        }
                    }
                }
                
                Section {
                    TextField("Add a new task", text: $name)
                        .onSubmit {
                            viewModel.addItem(name: name)
                            name = ""
                        }
                }
                
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
                                ForEach(STATES, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                }
                .onDelete(perform: viewModel.delete(index:))
            }
            .navigationTitle("My List")
        }
    }
    
}

#Preview {
    ContentView()
}
