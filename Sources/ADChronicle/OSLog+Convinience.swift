import Foundation
import os

@available(OSX 10.12, *)
@available(iOS 10.0, *)
extension OSLog {
    convenience init<Subject>(subsystem: String, category: Subject) {
        self.init(subsystem: subsystem, category: String(describing: category))
    }
}
