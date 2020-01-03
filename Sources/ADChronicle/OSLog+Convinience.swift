import Foundation
import os

@available(iOS 10.0, *)
extension OSLog {
    convenience init<Subject>(subsystem: String, category: Subject) {
        self.init(subsystem: subsystem, category: String(describing: category))
    }
}
