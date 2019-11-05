import Foundation
import SwiftCLI
import RxSwift

let version = "0.1.0"
let emoji = "🐦"

final class MainCommand: Command {
    let name = "run"
    let path = OptionalParameter()
    func execute() throws {

        let workspace = "\(NSHomeDirectory())/.rxpl/workspace"
        let sourceDir = "\(workspace)/Sources/rxplws"
        let mainswift = "\(sourceDir)/main.swift"
        let defaultContent = """
        import RxSwift
        print("Hello rxpl!")
        """.data(using: .utf8)!
        let fm = FileManager.default

        func configureWorkspace() throws {
            if fm.fileExists(atPath: workspace) {
                return
            }

            // setup
            stdout <<< "\(emoji) Initializing workspace. This may take minutes..."

            let packageswift: Data = """
            // swift-tools-version:5.1
            import PackageDescription

            let package = Package(
                name: "rxplws",
                dependencies: [
                    .package(url: "https://github.com/ReactiveX/RxSwift", from: "5.0.1"),
                ],
                targets: [
                    .target(name: "rxplws", dependencies: ["RxSwift", "RxRelay"]),
                ]
            )
            """.data(using: .utf8)!

            try fm.createDirectory(at: URL(fileURLWithPath: sourceDir), withIntermediateDirectories: true, attributes: nil)

            assert(fm.createFile(atPath: "\(workspace)/Package.swift", contents: packageswift, attributes: nil))
            assert(fm.createFile(atPath: mainswift, contents: defaultContent, attributes: nil))

            Task(executable: "/bin/bash",
                     arguments: ["-c", "swift build"],
                     directory: workspace,
                     stdout: stdout).runSync()

            stdout <<< "\(emoji) Initialize OK"
        }

        try configureWorkspace()

        // session start

        let data: Data = {
            if let path = path.value {
                return fm.contents(atPath: path)!
            } else {

                var lines: [String] = []

                while let line = readLine() {
                    lines.append(line)
                }

                return lines.joined(separator: "\n").data(using: .utf8)!

            }
        }()

        if !data.isEmpty {
            if fm.fileExists(atPath: mainswift) {
                try fm.removeItem(at: URL(fileURLWithPath: mainswift))
            }
        }

        assert(fm.createFile(atPath: mainswift, contents: data, attributes: nil))

        try Task.run(bash: "swift run", directory: workspace)
    }
}

let rxpl = CLI(name: "rxpl",
               version: version,
               description: "RxSwift Playground in CLI",
               commands: [MainCommand()])

exit(rxpl.go())
