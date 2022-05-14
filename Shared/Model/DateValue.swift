//
//  DateValue.swift
//  Final
//
//  Created by Kiana Jung on 5/8/22.

//  This file holds the variables for the date

import SwiftUI

//Date Value Model
struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
