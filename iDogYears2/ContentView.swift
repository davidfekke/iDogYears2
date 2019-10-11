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
    @State private var dogyears: String?
    
    private func getDogYears(for age: Float?) -> String {
        if let realAge = age {
            let dogYears = realAge * 7
            return String(dogYears)
        } else {
            return ""
        }
    }
    
    private var floatFormatter: NumberFormatter = {
        let f = NumberFormatter()
        // allow no currency symbol, extra digits, etc
        f.isLenient = true
        f.numberStyle = .decimal
        return f
    }()
    
    var body: some View {

            VStack(alignment: .leading) {
                Text("Enter Dog's Age")
                    .font(.largeTitle)
                    .background(Color.white)
                // TextField("Age", value: $age, formatter: floatFormatter)
                //TextField("Age", value: $age,  formatter: floatFormatter)
                TextField("Age", text: $age)
                    .background(Color.pink)
                    .keyboardType(.decimalPad)
                
                Button(action: processDogyears) {
                    Text("Calculate")
                        .font(.largeTitle)
                }
                if dogyears != nil {
                    Text("Your pooch is \(self.dogyears ?? "0") in Dogyears!").background(Color(.sRGB, red: 255, green: 255, blue: 255, opacity: 0.5))
                }
                
                Spacer()
                
            }
                .padding()
                .background(Image("dogWithPass"))
            .onTapGesture {
                self.endEditing()
                
        }
        
    }
    
    private func processDogyears() -> Void {
        if let floatAge = Float(age) {
            let dogyearsFloat = CalculateDogAge.calculate(years: floatAge, weight: 18)
            print("Processing:  \(floatAge)")
            self.dogyears = String(dogyearsFloat)
        } else {
                self.dogyears = nil
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
