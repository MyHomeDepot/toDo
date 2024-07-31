import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ListModel()
    @State private var title = ""
    
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
                    TextField("Add a new task", text: $title)
                        .onSubmit {
                            viewModel.addItem(title: title)
                            title = ""
                        }
                }
                
                ForEach (viewModel.todos) { todo in
                    Section {
                        VStack {
                            HStack {
                                TextField(todo.title, text: Binding(
                                    get: { todo.title },
                                    set: { newTitle in
                                        viewModel.changeTitle(todo: todo, title: newTitle)
                                    }
                                ))
                                Spacer()
                                Button {
                                    viewModel.checkToggle(todo: todo)
                                } label: {
                                    Image(systemName: todo.isComplited ? "checkmark" : "square")
                                }
                            }
                            Spacer()
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
