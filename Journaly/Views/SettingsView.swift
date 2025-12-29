//
//  SettingsView.swift
//  Journaly
//
//  Created by David Adekunle on 07/12/2024.
//

import SwiftUI
import SwiftData
import PhotosUI

//authenticating faceID
import LocalAuthentication

struct SettingsView: View {
    @State var nameTxt : String = ""
    @Binding var backgroundColor: Color
    @State var settingBlurToggle = true
    @State var enableFaceID = false
    @State var notificationToggle = false
    @State var icloudSyncToggle = false
    @State var lockToggle = 4
    @State var userAvatar : UIImage?
    @State var photosPicker : PhotosPickerItem?
    //var JournalWrapped 
    @Environment(\.modelContext) var context
    @Query var settingsModel: [SettingsModel]
    //@Bindable var settingsManager: SettingsModel
    
    //tracking face ID
    @State var isUnlocked = false
    var authenticateOnce = false
    
    var body: some View {
        NavigationStack {
            if isUnlocked{
                List {
                    
                    Section {
                        VStack(alignment: .center) {
                            
                            //photos picker for user's profile
                            PhotosPicker(selection: $photosPicker, matching: .images) {
                                
                                if let avatar = userAvatar{
                                    Image(uiImage: avatar)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 110, height: 110)
                                    //.font(.system(size: 100))
                                        .shadow(radius: 4)
                                        .clipShape(Circle())
                                }else{
                                    Image(systemName: "person.crop.circle.badge.plus")
                                        .font(.system(size: 100))
                                        .foregroundStyle(.fill)
                                        .background(.ultraThinMaterial.opacity(0))
                                        .shadow(radius: 4)
                                }
                            }
                            
                            
                            
                            
                            if !nameTxt.isEmpty{
                                Text(nameTxt)
                                    .font(.largeTitle)
                                    .bold()
                            }else{
                                Text("Name")
                                    .font(.largeTitle)
                                    .bold()
                            }
                            
                            
                            Text("Manage your name, background images and Color, journals and more.")
                                .multilineTextAlignment(.center)
                            //.padding(.top, 2)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical)
                        .listRowBackground(Color.clear)
                        .onChange(of: photosPicker){ _, _ in
                            
                            Task{
                                if let photosPicker,
                                   let data = try? await photosPicker.loadTransferable(type: Data.self){
                                    if let image = UIImage(data: data){
                                        userAvatar = image
                                    }
                                }
                                photosPicker = nil
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Name")) {
                        HStack {
                            Image(systemName: "lanyardcard")
                            TextField("Your name", text: $nameTxt)
                        }
                        
                        
                    }
                    
                    Section(header: Text("Backgrounds")) {
                        HStack {
                            Image(systemName: "circle.dotted")
                                .frame(width: 30)
                                .foregroundStyle(.secondary)
                            
                            
                            Toggle(isOn: $settingBlurToggle){
                                Text("Enable Blur")
                            }
                        }
                        NavigationLink(destination: BackgroundPickerView(bacckgroundColor: $backgroundColor)) {
                            HStack {
                                Image(systemName: "squareshape.dotted.squareshape")
                                    .frame(width: 30)
                                    .foregroundStyle(.secondary)
                                Text("Journal Backgrounds")
                            }
                        }
                    }
                    
                    Section(header: Text("Privacy")){
                        HStack {
                            Image(systemName: "faceid")
                            //.frame(width: 40)
                                .font(.title2)
                                .foregroundStyle(.fill)
                                .background(.ultraThinMaterial.opacity(0))
                                .padding(.trailing,10)
                            
                            
                            Toggle(isOn: $enableFaceID){
                                Text("Enable Face ID")
                                    .font(.body)
                            }
                        }
                        
                        HStack {
                            Image(systemName: "bell.badge")
                            //.frame(width: 40)
                                .font(.title2)
                                .foregroundStyle(.fill)
                                .background(.ultraThinMaterial.opacity(0))
                                .padding(.trailing,10)
                            
                            
                            Toggle(isOn: $notificationToggle){
                                Text("Daily Reminder")
                                    .font(.body)
                            }
                        }
                        
                        HStack {
                            Image(systemName: "icloud")
                            //.frame(width: 40)
                                .font(.title2)
                                .foregroundStyle(.fill)
                                .background(.ultraThinMaterial.opacity(0))
                                .padding(.trailing,10)
                            
                            
                            Toggle(isOn: $icloudSyncToggle){
                                Text("iCloud Sync")
                                    .font(.body)
                            }
                        }
                        
                        HStack {
                            Image(systemName: "lock.app.dashed")
                            //.frame(width: 40)
                                .font(.title2)
                                .foregroundStyle(.fill)
                                .background(.ultraThinMaterial.opacity(0))
                                .padding(.trailing,10)
                            
                            
                            
                            Picker(selection: $lockToggle, label: Text("Auto Lock after")) {
                                Text("1 min").tag(1)
                                Text("5 min").tag(2)
                                Text("10 min").tag(3)
                                Text("Never").tag(4)
                            }
                            // .defaultWheelPickerItemHeight(30)
                            
                            
                            
                        }
                        
                    }
                    
                    Section(header: Text(".Misc")){
                        NavigationLink(destination: JournalyWrapped()) {
                            HStack {
                                Image(systemName: "timelapse")
                                    .frame(width: 30)
                                    .foregroundStyle(.secondary)
                                Text("Journal Wrapped")
                            }
                        }
                        
                        
                    }
                    
                    Section(header: Text("Danger Zone")){
                        Button{
                            
                        }label: {
                            HStack {
                                Image(systemName: "trash")
                                    .frame(width: 30)
                                Text("Delete all Journals")
                            }
                            .foregroundStyle(.red)
                        }
                    }
                }
                .navigationTitle("Settings")
                .background(Color.red)
                .onAppear{
                    if let existingName = settingsModel.first{
                        nameTxt = existingName.userName
                    } else{
                        let newName = SettingsModel(userName: "", settinBlurToggle: true)
                        context.insert(newName)
                        try? context.save()
                    }
                }
                .onChange(of: nameTxt){ oldName, newName in
                    if let existingName = settingsModel.first{
                        existingName.userName = newName
                        try? context.save()
                    }
                }
            } else{
                VStack{
                    Text("Standby for authentication")
                        .font(.largeTitle)
                    Spacer()
                }
            }
        }
        .onAppear(perform: authenticateID)
    }
    
    func authenticateID(){
        let context = LAContext()
        var error : NSError?
        
        guard !authenticateOnce else {return}
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Face ID is used to unlock your Journals"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                if success {
                    //authentication successful
                    isUnlocked = true
                    //authenticateOnce = true
                    
                } else{
                    //failed
                    isUnlocked = false
                }
            }
        } else{
            //no biometrics detected...
        }
    }
}

#Preview {
    SettingsView(backgroundColor: .constant(.HazeBrown))
}

struct ListView: View{
    var body: some View{
        HStack{
            Image(systemName: "person.crop.circle")
            Text("Name")
        }
    }
}
