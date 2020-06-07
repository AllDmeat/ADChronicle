//
//  ADLogServiceProtocol.swift
//  
//
//  Created by Алексей Берёзка on 06.06.2020.
//

import Foundation
import os

public protocol ADLogServiceProtocol {
    func log(_ error: Error,
             file: StaticString,
             function: StaticString,
             line: UInt)
    
    func log(_ message: String,
             userInfo: CustomDebugStringConvertible?,
             logLevel: OSLogType,
             file: StaticString,
             function: StaticString,
             line: UInt)
}
