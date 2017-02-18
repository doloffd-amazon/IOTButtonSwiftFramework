//
//  IOTButtonEvent.swift
//  SwiftLambdaHandler
//
//  Created by Doloff, Dustin on 2/17/17.
//
//

import Foundation

// Example JSON request
// { "serialNumber": "G030JF050184WWAN", "batteryVoltage": "1584mV", "clickType": "SINGLE" }
public struct IOTButtonEvent : CustomStringConvertible {
    public enum ClickType : String {
        case SINGLE = "SINGLE"
        case DOUBLE = "DOUBLE"
        case LONG = "LONG"
        case UNKNOWN = "UNKNOWN"
    }
    
    let serialNumber : String
    let batteryVoltage : Int
    let clickType : ClickType
    
    public init(requestJson: [String:String]) {
        let serialNumber = requestJson["serialNumber"] ?? ""
        let batteryVoltage = Int((requestJson["batteryVoltage"] ?? "").trimmingCharacters(in: ["m", "V"]), radix:10) ?? Int.min
        let clickType = ClickType(rawValue: requestJson["clickType"]!) ?? ClickType.UNKNOWN
        self.init(serialNumber: serialNumber, batteryVoltage: batteryVoltage, clickType: clickType)
    }
    
    public init(serialNumber: String, batteryVoltage: Int, clickType: ClickType) {
        self.serialNumber = serialNumber
        self.batteryVoltage = batteryVoltage
        self.clickType = clickType
    }
    
    public var description: String {
        return "[ Serial: \(serialNumber) Battery: \(batteryVoltage)mV clickType: \(clickType) ]"
    }
}
