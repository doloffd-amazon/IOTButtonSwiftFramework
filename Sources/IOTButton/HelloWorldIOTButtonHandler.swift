//
//  HelloWorldIOTButtonHandler.swift
//  SwiftLambdaHandler
//
//  Created by Doloff, Dustin on 2/17/17.
//
//

import Foundation

public class HelloWorldIOTButtonProtocolHandler : IOTButtonProtocolHandler {
    public init() {
        super.init(handler: HelloWorldHandler())
    }
}

fileprivate class HelloWorldHandler : IOTButtonHandler {
    func onHandle(event: IOTButtonEvent) -> Bool {
        print(event)
        return true
    }
}


