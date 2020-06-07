import Foundation
import os

@available(iOS 12.0, *)
@available(OSX 10.14, *)
public class ADChronicle {
    private static var logServices = [ADLogServiceProtocol]()
    
    public static func configure(with logServices: [ADLogServiceProtocol]) {
        self.logServices = logServices
    }
    
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
                           logType: OSLogType = .default,
                           signpostType: OSSignpostType = .event,
                           file: StaticString = #file,
                           function: StaticString = #function,
                           line: UInt = #line) {
        for logService in logServices {
            logService.log(message,
                           userInfo: userInfo,
                           logType: logType,
                           signpostType: signpostType,
                           file: file,
                           function: function,
                           line: line)
        }
    }
}
