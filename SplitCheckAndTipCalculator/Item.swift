//
//  Item.swift
//  SplitCheckAndTipCalculator
//
//  Created by Batuhan Balkilic on 10/18/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
