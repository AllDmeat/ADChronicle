//
//  ADLogServiceProtocol.swift
//  
//
//  Created by Алексей Берёзка on 06.06.2020.
//

import Foundation
import os

@available(iOS 12.0, *)
@available(OSX 10.14, *)
public protocol ADLogServiceProtocol {
    func log(_ error: Error,
             file: StaticString,
             function: StaticString,
             line: UInt)
    
    func log(_ message: String,
             userInfo: CustomDebugStringConvertible?,
             logType: OSLogType,
             signpostType: OSSignpostType,
             file: StaticString,
             function: StaticString,
             line: UInt)
}
