//
//  ContentView.swift
//  TipCalculator
//
//  Created by Batuhan Balkilic on 10/12/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \DataModel.date, order: .reverse) var dataModel: [DataModel]
    
    
    @FocusState private var amoundFocus: Bool
    @State private var checkAmount = 0.0
    @State private var splitOfPeople = 2
    @State private var percentageTip = 20
    @State private var showAlert: Bool = false
    @State private var itemToDelete: Int? = nil
    
    let tipPercentages = [15,20,25,30,0]
    
    
    var totalAmount: Double {
        let countOfPeople = Double(splitOfPeople)
        let countOfTip = Double(percentageTip)
        
        let amountOfTip = checkAmount / 100 * countOfTip
        let grandtotal = checkAmount + amountOfTip
        let perPersontotal = grandtotal / countOfPeople
        
        return perPersontotal
        
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section{
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amoundFocus)
                        Picker("Number of People", selection: $splitOfPeople){
                            ForEach(2..<40){number in
                                Text("\(number) People").tag(number)
                            }
                        }
                        Picker("Tip Percentage", selection: $percentageTip){
                            ForEach(tipPercentages, id: \.self){
                                Text($0, format: .percent)
                            }
                            
                        }
                        .pickerStyle(.segmented)
                        
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .font(.title3)
                            .bold()
                        HStack{
                            Spacer()
                            Button("Save") {
                                addData()
                            }
                            Spacer()
                        }
                    }
                    Section("History"){
                        VStack {
                            GeometryReader { geometry in
                                ScrollView {
                                    LazyVStack(spacing: 10) {
                                        ForEach(dataModel.indices, id:\.self) {index in
                                            let datamodels = dataModel[index]
                                            
                                            VStack() {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.white)
                                                    .shadow(radius: 3)
                                                    .frame(width: geometry.size.width * 0.9, height: 60)
                                                    .overlay {
                                                        VStack(spacing: 7) {
                                                            HStack {
                                                                Text(datamodels.date, format: Date.FormatStyle(date: .numeric, time: .shortened))
                                                                    .frame(maxWidth: .infinity)
                                                                Button {
                                                                    itemToDelete = index
                                                                    showAlert.toggle()
                                                                }
                                                                
                                                                
                                                            label: {
                                                                Image(systemName: "xmark")
                                                                    .foregroundStyle(.red)
                                                            }
                                                                
                                                                
                                                            }
                                                            
                                                            HStack{
                                                                Text("$\(datamodels.grandTotal)")
                                                                //.font(.title3)
                                                                    .foregroundStyle(Color.red)
                                                                    .frame(maxWidth: .infinity)
                                                                Text("\(datamodels.splitOfPeople)")
                                                                    .frame(maxWidth: .infinity)
                                                                Text(datamodels.percentageTip)
                                                                    .frame(maxWidth: .infinity)
                                                                //                                                                Text("$\(datamodels.checkAmount)")
                                                                //                                                                    .frame(maxWidth: .infinity)
                                                            }
                                                        }
                                                        .padding()
                                                    }
                                            }
                                            
                                            
                                        }
                                        
                                    }
                                    .padding(.top, 10)
                                    
                                    
                                    
                                }
                            }
                            
                        }
                        .frame(height: 450)
                    }
                    
                    
                    
                    
                    
                }
                .navigationTitle("Split Check")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if amoundFocus {
                        Button("Done") {
                            amoundFocus = false
                        }
                    }
                }
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Confirm to Delete ?"), primaryButton: Alert.Button.default(Text("DELETE"), action: {
                if let toDelete = itemToDelete {
                    deleteItems(offsets: IndexSet(arrayLiteral: toDelete))
                }            }), secondaryButton: Alert.Button.cancel())
        }
        
        
    }
    func addData() {
        let addData = DataModel(checkAmount: String(format: "%.2f",checkAmount),
                                splitOfPeople: "\(splitOfPeople)",
                                percentageTip: "%\(percentageTip)",
                                grandTotal: String(format: "%.2f",totalAmount),
                                date: Date())
        modelContext.insert(addData)
        
    }
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(dataModel[index])
            }
        }
    }
    
    
}

#Preview {
    ContentView()
        .modelContainer(for: DataModel.self,inMemory: true)
}
