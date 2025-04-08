//
//  Log.swift
//  
//
//  Created by Vladislav Lisianskii on 13.11.2021.
//

import CocoaLumberjackSwift
import Foundation

protocol LogProtocol {
    func verbose(_ message: DDLogMessageFormat)
    func info(_ message: DDLogMessageFormat)
    func warn(_ message: DDLogMessageFormat)
    func debug(_ message: DDLogMessageFormat)
    func error(_ message: DDLogMessageFormat)
}

final class Log {
    init() { }

    func initializeLoggers() {
        DDLog.add(DDOSLogger.sharedInstance)
    }
}

// MARK: - LogProtocol
extension Log: LogProtocol {
    func verbose(_ message: DDLogMessageFormat) {
        DDLogVerbose(message)
    }

    func info(_ message: DDLogMessageFormat) {
        DDLogInfo(message)
    }

    func warn(_ message: DDLogMessageFormat) {
        DDLogWarn(message)
    }

    func debug(_ message: DDLogMessageFormat) {
        DDLogDebug(message)
    }

    func error(_ message: DDLogMessageFormat) {
        DDLogError(message)
    }
}
