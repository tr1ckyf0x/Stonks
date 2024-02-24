//
//  Log.swift
//  
//
//  Created by Vladislav Lisianskii on 13.11.2021.
//

import Foundation
import CocoaLumberjackSwift

final class Log { }

// MARK: - Internal methods
extension Log {
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
