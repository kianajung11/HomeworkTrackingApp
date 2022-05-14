
//
//  CustomDatePicker.swift
//  Final
//
//  Created by Kiana Jung on 5/8/22.

//  This is a struct of a custom date picker

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    @FetchRequest(sortDescriptors:[]) private var HWData: FetchedResults<HWD>
    func image(for state: Bool) -> Image {
            return state ? Image(systemName: "checkmark.circle") : Image(systemName: "circle")
        }
    
    var body: some View {
        VStack(spacing: 35){
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            //calendar heading
            HStack(spacing: 20){
                VStack(alignment: .leading, spacing: 10){
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                Spacer(minLength: 0)
                Button{
                    withAnimation{
                        currentMonth -= 1
                    }
                } label:{
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Button{
                    withAnimation{
                        currentMonth += 1
                    }
                } label:{
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }.padding(.horizontal)
            
            //days
            HStack(spacing: 0){
                ForEach(days, id: \.self){day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            //dates
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15){
                ForEach(extractDate()){value in
                    CardView(value: value)
                        .onTapGesture{
                            currentDate = value.date
                        }
                }
            }
        }.onChange(of: currentMonth){ newValue in
            currentDate = getCurrentMonth()}

        
        //task view
        VStack(spacing: 15){
            Text("Assignments")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            if HWData.first(where: {task in
                return isSameDay(date1: task.date ?? Date(), date2: currentDate)
            }) != nil{
                ForEach(HWData, id:\.self){task in self.taskView(date: task.date ?? Date(), task: task)
                
//                taskView(date: task.date ?? Date())
                    
//                    task in
//                    VStack(alignment: .leading, spacing: 10){
//                        Text(task.date ?? Date(), style: .time)
//                        Text(task.name ?? "")
//                            .font(.title2.bold())
//                        Text(task.descriptionn ?? "")
//                            .font(.subheadline)
//                    }.padding(.vertical,10)
//                        .padding(.horizontal)
//                        .frame(maxWidth: .infinity,alignment: .leading)
//                        .background(
//                            Color(.gray)
//                                .opacity(0.5)
//                                .cornerRadius(10))
                }
            }else{
                Text("No Assignments Found")
            }
        }.padding()
            .padding(.top,20)
    }
    
    //for clicking on each day
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        VStack{
            if value.day != -1{
                if HWData.first(where: { task in
                    return isSameDay(date1: task.date ?? Date(), date2: currentDate)
                }) != nil{
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .red : .primary)
                        .frame(maxWidth: .infinity)
                }
                else{
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .red : .primary)
                    
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }.padding(.vertical,9)
            .frame(height: 60, alignment: .top)
    }
    
    @ViewBuilder
    func taskView(date: Date, task: FetchedResults<HWD>.Element) -> some View {
            if(isSameDay(date1: task.date ?? Date(), date2: currentDate)){
                VStack(alignment: .leading, spacing: 10){
                    Text(task.date ?? Date(), style: .time)
                    Text(task.name ?? "")
                        .font(.title2.bold())
                    Text(task.descriptionn ?? "")
                        .font(.subheadline)
                }.padding(.vertical,10)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(
                        Color(.gray)
                            .opacity(0.5)
                            .cornerRadius(10))
        }
    }
    
    //checking dates
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    //extracting year and month for display
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    //get the current month
    func getCurrentMonth()->Date{
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())else{
            return Date()
        }
        return currentMonth
    }
    
    //get date
    func extractDate()->[DateValue]{
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap{ date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from:days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//extending date to get current month dates
extension Date{
    func getAllDates()->[Date]{
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
