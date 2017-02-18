import Foundation
import AlexaSkill
import AlexaSkillsKit
import IOTButton

let HANDLERS : [IOTButtonProtocolHandler] = [
    HelloWorldIOTButtonProtocolHandler()
]

func stringToData(string: String) -> Data {
    return string.data(using: String.Encoding.utf8) ?? Data()
}

let data : Data = FileHandle.standardInput.readDataToEndOfFile()

for handler in HANDLERS {
    if !handler.handle(data: data) {
        FileHandle.standardError.write(stringToData(string: "\(handler) failed\n"))
    } else {
        FileHandle.standardOutput.write(stringToData(string: "\(handler) succeeded\n"))
    }
}
