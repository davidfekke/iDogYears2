//
//  ContentView.swift
//  iDogYears2
//
//  Created by David Fekke on 10/7/19.
//  Copyright © 2019 David Fekke. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var dogyears: String?
    @State var errorMessage: String?
    
    var ageNumber: NSNumber {
        let formatter = NumberFormatter()
        guard let number = formatter.number(from: age) else {
            print("not valid to be converted")
            return 0
        }
        return number
    }
    
    var weightNumber: NSNumber {
        let formatter = NumberFormatter()
        guard let number = formatter.number(from: weight) else {
            print("not valid to be converted")
            return 0
        }
        return number
    }
    
    var body: some View {

            VStack(alignment: .leading) {
                Text("Enter Dog's Age")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.black)
                
                TextField("Age", text: $age)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .colorScheme(.light)
                    .onTapGesture {
                        print("ghjghjhgjk")
                        if Float(truncating: self.ageNumber) == 0 {
                            self.age = ""
                        }
                    }
                TextField("Weight in Pounds", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .colorScheme(.light)
                    .onTapGesture {
                        print("ghjghjhgjk")
                        if Float(truncating: self.weightNumber) == 0 {
                            self.weight = ""
                        }
                    }
                Button(action: processDogyears) {
                    Spacer()
                    Text("Calculate")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.all)
                    .background(/*@START_MENU_TOKEN@*/Color.green/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8.0)
                            
                Divider()
                if dogyears != nil {
                        Text("Your pooch is \(self.dogyears ?? "0") in Dogyears!")
                            .colorScheme(.light)
                        
                }
                if errorMessage != nil {
                    Text(String(self.errorMessage ?? ""))
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
                .padding()
            .background(Image("Thumper").resizable().scaledToFill())
            .onTapGesture {
                self.endEditing()
                
        }
        
    }
    
    private func processDogyears() -> Void {
        print("Age: \(ageNumber), Weight: \(weightNumber)")
        if Float(truncating: ageNumber) > 0 && Float(truncating: weightNumber) > 0 {
            let dogyearsFloat = CalculateDogAge.calculate(years: Float(truncating: ageNumber), weight: Float(truncating: weightNumber))
            self.dogyears = String(format: "%.2f", dogyearsFloat)//String(dogyearsFloat)
            
            self.errorMessage = nil
        } else {
            self.dogyears = nil
            self.errorMessage = "The age and weight fields both need numerical values"
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
