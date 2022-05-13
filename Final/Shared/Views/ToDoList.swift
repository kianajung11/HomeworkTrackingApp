//
//  ToDoList.swift
//  Final
//
//  Created by Kiana Jung on 5/11/22.
//  This code is the view for to do list

import SwiftUI

struct ToDoList: View {
    @State private var showAddTodoView = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors:[]) private var HWData: FetchedResults<HWD>
    func image(for state: Bool) -> Image {
            return state ? Image(systemName: "checkmark.circle") : Image(systemName: "circle")
        }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(HWData, id:\.self){ todo in
                    NavigationLink(destination:
                        VStack(spacing: 10){
                        Text(todo.name ?? "untitled")
                            .font(.title)
                        Text(todo.descriptionn ?? "")
                            .font(.headline)
                        HStack {
                            Text("Completed").font(.headline)
//                            Image(systemName: todo.isCompleted ?
//                                  "checkmark.circle" : "circle")
                            self.image(for: todo.isCompleted).onTapGesture {
                                todo.isCompleted.toggle()
                            }
//                            Toggle(isOn: todo.isCompleted) {
//                                Text("Completed").font(.headline)}
                        }
                        HStack {
                            Text(todo.date ?? Date(), style: .date)
                            Text(todo.date ?? Date(), style: .time)
//                                .frame(maxHeight: 400)
                        }
//                        Text(todo.notes ?? "")
                    }
                    ){
                        self.image(for: todo.isCompleted).onTapGesture {
                            todo.isCompleted.toggle()
                        }
                        Text(todo.name ?? "untitled")
                    }.onTapGesture(count: 2, perform: {
                        updateTodo(todo: todo)
                    })
                }.onDelete(perform: { indexSet in deleteTodo(offsets: indexSet)
                })
            }.navigationBarTitle("Assignment List")
                .navigationBarItems(
                    leading: Button("Add"){
                        self.showAddTodoView.toggle()
                    }.sheet(isPresented: $showAddTodoView){
                        AddTodoView(showAddTodoView: self.$showAddTodoView, isCompleted: false)
                    },
                    trailing: EditButton()
                )
        }
    }
    
    private func deleteTodo(offsets: IndexSet){
        for index in offsets{
            let todo = HWData[index]
            viewContext.delete(todo)
        }
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("unresolved error:\(error)")
        }
    }
    
    private func updateTodo(todo: FetchedResults<HWD>.Element){
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("unresolved error:\(error)")
        }
    }
}

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToDoList()
        }
    }
}


struct AddTodoView: View {
    @Binding var showAddTodoView: Bool
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var name: String = ""
    @State var descriptionn: String = ""
    @State var isCompleted: Bool
    @State var date = Date()
//    @State var notes: String = ""
    
    var body: some View {
        VStack{
            VStack{
                Text("Add Assignment")
                //                .font(.largeTitle)
                TextField("Assignment Name",text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black).padding()
            }.padding(.top)
            VStack{
                Text("Add description")
                //                .font(.largeTitle)
                TextField("Description",text: $descriptionn)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black).padding()
            }
            HStack {
                Toggle(isOn: $isCompleted) {
                    Text("Completed").font(.headline)
                }
            }
            VStack {
                Text("Add date")
                //                    .font(.largeTitle)
                DatePicker("Date", selection: $date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                //                    .frame(maxHeight: 400)
            }
//            VStack{
//                Text("Add Notes")
//                //                .font(.largeTitle)
//                TextField("Notes",text: $notes)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .frame(maxWidth: .infinity)
//                    .border(Color.black).padding()
//            }.padding(.top)
            
        }.padding()
        
        Button("Done"){
            self.showAddTodoView = false
            let newHWD = HWD(context: viewContext)
            newHWD.name = name
            newHWD.descriptionn = descriptionn
            newHWD.isCompleted = isCompleted
            newHWD.date = date
//            newHWD.notes = notes
            
            do{
                try viewContext.save()  //Here we save in coreData
            }
            catch{
                let error = error as NSError
                fatalError("unresolved error:\(error)")
            }
        }
    }
}
