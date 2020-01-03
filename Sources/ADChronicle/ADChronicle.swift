import Foundation
import os

public typealias ADLogger = OSLog

@available(OSX 10.14, *)
@available(iOS 12.0, *)
public class ADChronicle {
    private static var loggers = [Int: ADLogger]()
    
    public static func logger<Subject>(subsystem: String, category: Subject) -> ADLogger {
        let hash = String(describing: category).hashValue
        
        if let logger = loggers[hash] { return logger }
        
        let logger = ADLogger(subsystem: subsystem, category: String(describing: category))
        loggers[hash] = logger
        return logger
    }
    
    public static func log(_ error: Error,
                           logger: ADLogger,
                           function: String = #function) {
        let message = String(reflecting: error)
        self.log(message, logger: logger, function: function, logType: .error)
    }
    
    public static func log(_ message: String,
                           userInfo: CustomDebugStringConvertible? = nil,
                           logger: ADLogger,
                           function: String = #function,
                           logType: OSLogType = .info) {
        let message = message + "\n\n" + "User Info:" + "\n" + String(describing: userInfo ?? [:])
        
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

