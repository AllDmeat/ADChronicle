import Foundation
import os

public typealias ADLogger = OSLog
public typealias ADLogType = OSLogType

// MARK: - Public
@available(OSX 10.14, *)
@available(iOS 12.0, *)
public class ADChronicle {
    internal static var loggers = [Int: ADLogger]()
    
    public static func log(_ error: Error,
                           file: StaticString = #file,
                           function: StaticString = #function,
                           line: UInt = #line) {
        self.log(String(reflecting: error),
                 userInfo: nil,
                 logger: logger(for: file),
                 file: file,
                 function: function,
                 logLevel: .error)
    }
    
    public static func log(_ message: String,
                           userInfo: CustomDebugStringConvertible? = nil,
                           logLevel: ADLogType = .default,
                           file: StaticString = #file,
                           function: StaticString = #function,
                           line: UInt = #line) {
        self.log(message,
                 userInfo: userInfo,
                 logger: logger(for: file),
                 file: file,
                 function: function,
                 logLevel: logLevel)
    }
}

// MARK: - os_log
@available(OSX 10.14, *)
@available(iOS 12.0, *)
extension ADChronicle {
    private static func log(_ message: String,
                            userInfo: CustomDebugStringConvertible?,
                            logger: ADLogger,
                            file: StaticString,
                            function: StaticString,
                            logLevel: ADLogType) {
        let message = message + "\n\n" + "[User Info]:" + "\n" + string(from: userInfo)
        
        #if DEBUG
        os_log(logLevel,
               log: logger,
               "%{public}@\n%{public}@", function.description, message)
        #else
        os_log(logLevel,
               log: logger,
               "%{public}@\n%{private}@", function.description, message)
        #endif
    }
}

// MARK: - User Info
@available(OSX 10.14, *)
@available(iOS 12.0, *)
extension ADChronicle {
    private static func string(from userInfo: CustomDebugStringConvertible?) -> String {
        if let dict = userInfo as? [String: Any] {
            return string(from: dict)
        } else {
            return String(describing: userInfo)
        }
    }
    
    private static func string(from parameters: [String: Any]) -> String {
        guard JSONSerialization.isValidJSONObject(parameters),
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
            let jsonString = String(data: jsonData, encoding: .utf8)
            else { return "" }
        
        return jsonString
    }
}

// MARK: Loggers
@available(OSX 10.14, *)
@available(iOS 12.0, *)
internal extension ADChronicle {
    static func filename(from file: StaticString) -> String {
        return URL(fileURLWithPath: file.description).deletingPathExtension().lastPathComponent
    }
    
    static func logger(for file: StaticString) -> ADLogger {
        return logger(subsystem: Bundle.main.bundleIdentifier!, file: file)
    }
    
    static func logger(subsystem: String, file: StaticString) -> ADLogger {
        let filename = self.filename(from: file)
        
        let hash = filename.hashValue
        
        if let logger = loggers[hash] { return logger }
        
        let logger = ADLogger(subsystem: subsystem, category: filename)
        loggers[hash] = logger
        return logger
    }
}
