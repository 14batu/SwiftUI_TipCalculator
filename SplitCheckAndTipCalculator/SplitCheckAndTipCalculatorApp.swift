//
//  SplitCheckAndTipCalculatorApp.swift
//  SplitCheckAndTipCalculator
//
//  Created by Batuhan Balkilic on 10/18/23.
//

import SwiftUI
import SwiftData

@main
struct SplitCheckAndTipCalculatorApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DataModel.self,inMemory: true)
    }
}
