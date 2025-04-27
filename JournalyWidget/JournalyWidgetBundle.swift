//
//  JournalyWidgetBundle.swift
//  JournalyWidget
//
//  Created by David Adekunle on 26/04/2025.
//

import WidgetKit
import SwiftUI

@main
struct JournalyWidgetBundle: WidgetBundle {
    var body: some Widget {
        JournalyWidget()
        JournalyWidgetControl()
        JournalyWidgetLiveActivity()
    }
}
