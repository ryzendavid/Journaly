//
//  SettingsModel.swift
//  Journaly
//
//  Created by David Adekunle on 06/04/2025.
//

import Foundation
import SwiftData
import Observation

@Model
class SettingsModel: ObservableObject {
    var userName : String = ""
    var settinBlurToggle = true
    
    init(userName: String, settinBlurToggle: Bool) {
        self.userName = userName
        self.settinBlurToggle = settinBlurToggle
    }
}
