import Foundation
import os

@available(OSX 10.14, *)
@available(iOS 12.0, *)
public class ADChronicle {
    public static func logger<Subject>(subsystem: String, category: Subject) -> OSLog {
        return OSLog(subsystem: subsystem, category: category)
    }
    
    public static func log(_ error: Error,
                           logger: OSLog,
                           function: String = #function) {
        let message = String(reflecting: error)
        self.log(message, logger: logger, function: function, logType: .error)
    }
    
    public static func log(_ message: String,
                           userInfo: CustomDebugStringConvertible? = nil,
                           logger: OSLog,
                           function: String = #function,
                           logType: OSLogType = .info) {
        let message = message + "\n\n" + "[User Info]:" + "\n" + String(describing: userInfo ?? [:])
        
        #if DEBUG
        os_log(logType,
               log: logger,
               "%{public}@\n%{public}@", function, message)
        #else
        os_log(logType,
               log: logger,
               "%{public}@\n%{private}@", function, message)
        #endif
    }
}

