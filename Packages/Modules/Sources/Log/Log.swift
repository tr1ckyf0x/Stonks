//
//  Log.swift
//  
//
//  Created by Vladislav Lisianskii on 13.11.2021.
//

import CocoaLumberjackSwift
import Foundation

public final class Log {
    public init() { }

    public func initializeLoggers() {
        DDLog.add(DDOSLogger.sharedInstance)
    }
}

// MARK: - LogProtocol
extension Log: LogProtocol {
    public func verbose(_ message: DDLogMessageFormat) {
        DDLogVerbose(message)
    }

    public func info(_ message: DDLogMessageFormat) {
        DDLogInfo(message)
    }

    public func warn(_ message: DDLogMessageFormat) {
        DDLogWarn(message)
    }

    public func debug(_ message: DDLogMessageFormat) {
        DDLogDebug(message)
    }

    public func error(_ message: DDLogMessageFormat) {
        DDLogError(message)
    }
}
