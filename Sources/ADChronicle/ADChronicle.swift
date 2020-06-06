import Foundation
import os

public class ADChronicle {
    public static var logServices = [ADLogServiceProtocol]()
    
    public static func log(_ error: Error,
                           file: StaticString = #file,
                           function: StaticString = #function,
                           line: UInt = #line) {
        for logService in logServices {
            logService.log(error,
                           file: file,
                           function: function,
                           line: line)
        }
    }
    
    public static func log(_ message: String,
                           userInfo: CustomDebugStringConvertible? = nil,
                           logLevel: ADLogLevel = .default,
                           file: StaticString = #file,
                           function: StaticString = #function,
                           line: UInt = #line) {
        for logService in logServices {
            logService.log(message,
                           userInfo: userInfo,
                           logLevel: logLevel,
                           file: file,
                           function: function,
                           line: line)
        }
    }
}
