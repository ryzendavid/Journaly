//
//  NavContext.swift
//  Journaly
//
//  Created by David Adekunle on 27/03/2025.
//

import Foundation
import SwiftUI

class NavContext: ObservableObject{
    @Published var selectedJournal : JournalModel?
}
