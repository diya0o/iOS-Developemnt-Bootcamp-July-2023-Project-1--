//
//  ContentView.swift
//  ToDoList
//
//  Created by Diya Alowdah on 08/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var detalil = Details()
    @ObservedObject var todo = ToDoViewModle()
    @State var searchBar: String = ""
    @State var showBacklog = false
    @State var showToDo = false
    @State var showDone = false
    @State var showInProgrees = false
    var body: some View {
        
        NavigationStack {
            VStack {
                
                HStack {
                    TextField("Enter in a new task", text: self.$searchBar)
                    Button(action: {
                        toAdd()
                    }, label: { Text("Add") })
                }
                
                
                .padding()
                Form {
                    Section {
                        if detalil.getTasksCount() == 0 {
                            Text("Press and hold to categorize tasks")
                            
                                .font(.headline)
                                .foregroundColor(.gray.opacity(0.5))
                            Text("there is no tasks")
                            
                                .padding()
                        } else {
                            List {
                                // To set value in list
                                ForEach(detalil.detalil.filter { !$0.todo && !$0.done && !$0.backlog && !$0.inProgrees }) { i in
                                    Text(i.dosome)
                                    
                                        .contextMenu {
                                            Button(action: {
                                                // Done the item
                                                if let index = detalil.detalil.firstIndex(where: { $0.id == i.id }) {
                                                    detalil.detalil[index].inProgrees = true
                                                }
                                            }) {
                                                Label("IN PROGREES", systemImage: "slowmo")
                                            }
                                            
                                            
                                            Button(action: {
                                                // Done the item
                                                if let index = detalil.detalil.firstIndex(where: { $0.id == i.id }) {
                                                    detalil.detalil[index].done = true
                                                }
                                            }) {
                                                Label("Done", systemImage: "checkmark")
                                            }
                                            
                                            // Flag the item
                                            Button(action: {
                                                if let index = detalil.detalil.firstIndex(where: { $0.id == i.id }) { detalil.detalil[index].todo = true}}){
                                                    Label("TO DO", systemImage: "checkmark")
                                                }
                                            
                                            
                                            Button(action: {
                                                // Mark the item as Baklog
                                                if let index = detalil.detalil.firstIndex(where: { $0.id == i.id }) {
                                                    detalil.detalil[index].backlog = true
                                                }
                                            }) {
                                                Label("Backlog", systemImage: "checkmark")
                                            }
                                        }
                                }
                                .onMove(perform: self.move)
                                .onDelete(perform: self.delete)
                                
                            }
                        }
                        
                        
                        if showToDo {
                            Section(header: Text("TO DO")) {
                                List {
                                    ForEach(detalil.detalil.filter { $0.todo }) { i in
                                        Text(i.dosome)
                                    }
                                    .onMove(perform: self.move)
                                    .onDelete(perform: self.delete)
                                }
                            }
                        }
                        
                        if showBacklog {
                            Section(header: Text("backlog")) {
                                List {
                                    ForEach(detalil.detalil.filter { $0.backlog }) { i in
                                        Text(i.dosome)
                                    }
                                    .onMove(perform: self.move)
                                    .onDelete(perform: self.delete)
                                }
                            }
                        }
                        if showInProgrees {
                            Section(header: Text("IN PROGREES")) {
                                List {
                                    ForEach(detalil.detalil.filter { $0.inProgrees }) { i in
                                        Text(i.dosome)
                                    }
                                    .onMove(perform: self.move)
                                    .onDelete(perform: self.delete)
                                }
                            }
                        }
                        if showDone {
                            Section(header: Text("Done")) {
                                List {
                                    ForEach(detalil.detalil.filter { $0.done }) { i in
                                        Text(i.dosome)
                                    }
                                    .onMove(perform: self.move)
                                    .onDelete(perform: self.delete)
                                }
                            }
                        }
                    }
                }
                
                .navigationBarTitle("To Do")
                .navigationBarItems(leading:EditButton())
                
                HStack {
                    Button(action: {
                        showBacklog = false
                        showInProgrees = true
                        showToDo = false
                        showDone = false
                    }, label: { Text("in progrees")
                            .bold()
                            .font(.system(size: 19))
                    })
                    .padding()
                    Button(action: {
                        showBacklog = true
                        showInProgrees = false
                        showToDo = false
                        showDone = false
                    }, label: { Text("backloog")
                            .bold()
                            .font(.system(size: 19))
                    })
                    Button(action: {
                        showBacklog = false
                        showInProgrees = false
                        showToDo = true
                        showDone = false
                    }, label: { Text("to do")
                            .bold()
                            .font(.system(size: 19))
                    })
                    .padding()
                    
                    
                    Button(action: {
                        showBacklog = false
                        showInProgrees = false
                        showToDo = false
                        showDone = true
                    }, label: { Text("done")
                            .bold()
                            .font(.system(size: 19))
                    })
                }
            }
        }
    }
    func toAdd() {
        if !searchBar.isEmpty {
            detalil.detalil.append(Information(dosome: searchBar))
            searchBar = ""
        }
    }
    func move(from source: IndexSet, to destination: Int) {
        detalil.detalil.move(fromOffsets: source, toOffset: destination)
    }
    func delete(at offsets: IndexSet) {
        detalil.detalil.remove(atOffsets: offsets)
    }
}

    
    
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
