//
//  SettingsView.swift
//  Journaly
//
//  Created by David Adekunle on 07/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @State var nameTxt : String = ""
    @Binding var backgroundColor: Color
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .center) {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 100))
                            .shadow(radius: 4)

                        Text("Name")
                            .font(.largeTitle)
                            .bold()

                        Text("Manage your name, background images and Color, support and more.")
                            .multilineTextAlignment(.center)
                            .padding(.top, 2)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                    .listRowBackground(Color.clear)
                }

                Section(header: Text("Name")) {
                    HStack {
                        Image(systemName: "lanyardcard")
                        TextField("Your name", text: $nameTxt)
                    }
                   
                }

                Section(header: Text("Backgrounds")) {
                    NavigationLink(destination: BackgroundPickerView(bacckgroundColor: $backgroundColor)) {
                        HStack {
                            Image(systemName: "squareshape.dotted.squareshape")
                                .foregroundStyle(.secondary)
                                .frame(width: 30)
                            Text("Journal Backgrounds")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            //.scrollContentBackground(.hidden)
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
