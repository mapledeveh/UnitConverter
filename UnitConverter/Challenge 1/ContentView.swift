//
//  ContentView.swift
//  Challenge 1
//
//  Created by Alex Nguyen on 2023-04-30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userInputTemp = 0.0
    @State private var userInputUnit = "Kelvin"
    @State private var userOutputUnit = "Celsius"
    
    @FocusState private var focusing: Bool
    
    @State private var userInputLength = 0.0
    @State private var userInputLenghtUnit = "kilometers"
    @State private var userOutputLenghtUnit = "miles"
    
    let temperatureUnits = [ "Celsius", "Fahrenheit", "Kelvin" ]
    let lengthUnits = [ "meters", "kilometers", "feet", "yards", "miles" ]
    
    let tempFormat = Measurement<UnitTemperature>.FormatStyle(width: .abbreviated, numberFormatStyle: .number)
    let lengthFormat = Measurement<UnitLength>.FormatStyle(width: .abbreviated, numberFormatStyle: .number)
        
    func lengthUnit(_ unit: String) -> UnitLength {
        switch unit {
        case "meters":
            return .meters
        case "kilometers":
            return .kilometers
        case "feet":
            return .feet
        case "yards":
            return .yards
        case "miles":
            return .miles
        default:
            return .meters
        }
    }
    func tempUnit(_ unit: String) -> UnitTemperature {
        switch unit {
        case "Kelvin":
            return .kelvin
        case "Fahrenheit":
            return .fahrenheit
        case "Celsius":
            return .celsius
        default:
            return .celsius
        }
    }
    
    func convertedResult(_ temp: Double,_ inUnit: String,_ outUnit: String) -> Double {
        Measurement(value: temp, unit: lengthUnit(inUnit)).converted(to: lengthUnit(outUnit)).value
    }
        
    var body: some View {
        NavigationView {
            Form {
                Group {
                    Section {
                        TextField("Enter a temperature", value: $userInputTemp, format: .number)
                            .keyboardType(.numberPad)
                            .focused($focusing)
                        
                        Picker("From", selection: $userInputUnit) {
                            ForEach(temperatureUnits, id: \.self) {
                                Text($0)
                            }
                        }
                        Picker("To", selection: $userOutputUnit) {
                            ForEach(temperatureUnits, id: \.self) {
                                Text($0)
                            }
                        }
                    } header: {
                        Text("Enter the temperature")
                    }
                    
                    Section {
                        Text(convertedResult(userInputTemp, userInputUnit, userOutputUnit), format: .number)
                    } header: {
                        Text("Temperature in \(userOutputUnit)")
                    }
                }
                
                Group {
                    Section {
                        TextField("Enter a length", value: $userInputLength, format: .number)
                            .keyboardType(.numberPad)
                            .focused($focusing)
                        Picker("From", selection: $userInputLenghtUnit) {
                            ForEach(lengthUnits, id: \.self) {
                                Text($0)
                            }
                        }
                        Picker("To", selection: $userOutputLenghtUnit) {
                            ForEach(lengthUnits, id: \.self) {
                                Text($0)
                            }
                        }
                    } header: {
                        Text("Enter the length")
                    }
                    
                    Section {
                        Text(convertedResult(userInputLength, userInputLenghtUnit, userOutputLenghtUnit), format: .number)
                    } header: {
                        Text("Length in \(userOutputLenghtUnit)")
                    }
                }
            }
            .navigationTitle("Unit Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusing = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
