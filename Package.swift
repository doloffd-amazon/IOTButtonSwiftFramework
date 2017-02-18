import PackageDescription

var package = Package(
    name: "SwiftLambdaHandler",
    targets: [
        Target(name: "IOTButton"),
        Target(name: "Lambda", dependencies: ["IOTButton"]),
        Target(name: "AlexaSkill")
    ],
    dependencies: [
        .Package(url: "https://github.com/choefele/AlexaSkillsKit", majorVersion: 0),
    ], 
    exclude: ["Sources/Server"])

#if os(macOS)
package.targets.append(Target(name: "Server", dependencies: ["AlexaSkill"]))
package.dependencies.append(.Package(url: "https://github.com/IBM-Swift/Kitura", majorVersion: 1, minor: 1))
package.dependencies.append(.Package(url: "https://github.com/IBM-Swift/HeliumLogger", majorVersion: 1, minor: 1))
package.exclude = []
#endif
