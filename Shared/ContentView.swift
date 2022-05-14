//
//  ContentView.swift
//  Shared
//
//  Created by App on 5/3/22.
//

// This is the main content view file with three tabs, to do list, calendar, and user information

import SwiftUI

struct ContentView: View {
    var body: some View {
        // uses tab views display all the infomation
        TabView() {
            VStack {
                ToDoList()
            }.tabItem {
                Image("to-do-list")
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
            }
            VStack {
                Home()
            }.tabItem {
                Image("calendar")
                    .foregroundColor(.blue)
            }
            VStack {
                UserInfo()
            }.tabItem {
                Image("user")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
