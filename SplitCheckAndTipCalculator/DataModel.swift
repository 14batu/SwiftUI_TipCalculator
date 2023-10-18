//  DataModel.swift
//  TipCalculator
//
//  Created by Batuhan Balkilic on 10/12/23.
//

import Foundation
import SwiftData

@Model
class DataModel {
    var checkAmount: String
    var splitOfPeople: String
    var percentageTip: String
    var grandTotal: String
    var date: Date
    
    init(checkAmount: String, splitOfPeople: String, percentageTip: String, grandTotal: String, date: Date) {
        
        self.checkAmount = checkAmount
        self.splitOfPeople = splitOfPeople
        self.percentageTip = percentageTip
        self.grandTotal = grandTotal
        self.date = date
    }

    
}
