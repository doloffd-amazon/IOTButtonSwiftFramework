import Foundation
import AlexaSkillsKit

// Implement this to determine if the handler was successful
public protocol IOTButtonHandler {
    func onHandle(event: IOTButtonEvent) -> Bool
}

// Base class for the handler. Subclass and pass the implementation of IOTButtonHandler in init
public class IOTButtonProtocolHandler {
    private let handler : IOTButtonHandler
    
    public init(handler: IOTButtonHandler) {
        self.handler = handler
    }
    
    public func handle(data: Data) -> Bool {
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String:String] {
            let event : IOTButtonEvent = IOTButtonEvent(requestJson: json!)
            return handler.onHandle(event: event)
        } else {
            return false
        }
    }
}
