//
//  LogProtocol.swift
//  
//
//  Created by Vladislav Lisianskii on 13.11.2021.
//

import CocoaLumberjackSwift
import Foundation

public protocol LogProtocol {
    func verbose(_ message: DDLogMessageFormat)
    func info(_ message: DDLogMessageFormat)
    func warn(_ message: DDLogMessageFormat)
    func debug(_ message: DDLogMessageFormat)
    func error(_ message: DDLogMessageFormat)
}
