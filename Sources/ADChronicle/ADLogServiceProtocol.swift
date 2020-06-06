//
//  ADLogServiceProtocol.swift
//  
//
//  Created by Алексей Берёзка on 06.06.2020.
//

import Foundation

public protocol ADLogServiceProtocol {
    func log(_ error: Error,
             file: StaticString,
             function: StaticString,
             line: UInt)
    
    func log(_ message: String,
             userInfo: CustomDebugStringConvertible?,
             logLevel: ADLogLevel,
             file: StaticString,
             function: StaticString,
             line: UInt)
}

public enum ADLogLevel {
    case `default`, debug, info, warning, error
}
