//
//  JournalFormModel.swift
//  Journaly
//
//  Created by David Adekunle on 24/11/2024.
//

import Foundation
import SwiftData

@Model
class JournalModel: Identifiable {
    var title : String
    var Image : String
    var date : Date
    var bodyContent : String
    
    
    init(title : String, Image: String, date: Date, bodyContent : String ){
        self.title = title
        self.Image = Image
        self.date = date
        self.bodyContent = bodyContent
    }
}

// let mockData : [JournalModel] = [
//    JournalModel(title: "Some Title", Image: "Hysterisis", date: Date(), bodyContent: "This is a sample body content")
// ]



// TODO
// create model for the form
// create ui for the app and pass relevant data



