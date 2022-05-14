//
//  Home.swift
//  Final
//
//  Created by Kiana Jung on 5/8/22.

//  This file calls the custom date picker

import SwiftUI

struct Home: View {

    @State var currentDate: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            VStack(spacing: 20){
                CustomDatePicker(currentDate: $currentDate)
            }.padding(.vertical)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
