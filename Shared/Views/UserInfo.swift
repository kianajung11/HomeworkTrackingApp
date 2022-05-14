//
//  UserInfo.swift
//  Final
//
//  Created by Kiana Jung on 5/12/22.

// This view allows the user to add thier information. The inputed information is then displayed as on the view as the user profile

import SwiftUI

struct UserInfo: View {
    
    // declared various state variables to store the user information such as the name, grade, school, major, etc
    @State private var inEditView = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors:[]) private var userInfo: FetchedResults<HWD>
    @Environment(\.editMode) private var editMode
    @State private var disableTextField = true
    @State private var name: String = ""
    @State private var grade: String = ""
    @State private var school: String = ""
    @State private var major: String = ""
    
    
    // sets all the information provided by the user. if infomation is not provided it is set to the defaults
    init(){
        if(userInfo.count <= 0){
            name = ""
            grade = ""
            school = ""
            major = ""
        }else{
            name = self.userInfo[0].userName ?? "Name"
            grade = self.userInfo[0].userGrade ?? "Grade"
            school = self.userInfo[0].userSchool ?? "School"
            major = self.userInfo[0].userMajor ?? "Major"
        }
    }
    
    
    
    var body: some View {
        VStack(){
            //heading
            HStack(){
                Text("User Information")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                EditButton()
            }.padding(.horizontal)
            Divider()
            //information fields
            VStack{
                TextField("Name", text: $name)
                    .disabled(disableTextField)
                    .onChange(of: editMode?.wrappedValue) { newValue in
                        if (newValue != nil) && (newValue!.isEditing) {
                            // Edit button tapped
                            disableTextField = false
                            userInfo[0].userName = newValue.debugDescription
                        }
                        else {
                            // Done button tapped
                            disableTextField = true
                        }
                    }.font(.title.bold())
                
                TextField("School", text: $school)
                    .disabled(disableTextField)
                    .onChange(of: editMode?.wrappedValue) { newValue in
                        if (newValue != nil) && (newValue!.isEditing) {
                            // Edit button tapped
                            disableTextField = false
                            userInfo[0].userSchool = school
                        }
                        else {
                            // Done button tapped
                            disableTextField = true
                        }
                    }.font(.title2)
                
                TextField("Grade", text: $grade)
                    .disabled(disableTextField)
                    .onChange(of: editMode?.wrappedValue) { newValue in
                        if (newValue != nil) && (newValue!.isEditing) {
                            // Edit button tapped
                            disableTextField = false
                            userInfo[0].userGrade = newValue.debugDescription
                        }
                        else {
                            // Done button tapped
                            disableTextField = true
                        }
                    }.font(.title2)
                
                TextField("Major", text: $major)
                    .disabled(disableTextField)
                    .onChange(of: editMode?.wrappedValue) { newValue in
                        if (newValue != nil) && (newValue!.isEditing) {
                            // Edit button tapped
                            disableTextField = false
                            userInfo[0].userMajor = newValue.debugDescription
                        }
                        else {
                            // Done button tapped
                            disableTextField = true
                        }
                    }.font(.title2)
            }.padding(.horizontal, 25.0)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfo()
    }
}
