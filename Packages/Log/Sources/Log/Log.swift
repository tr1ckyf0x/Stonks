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
    func verbose(_ message: String) {
        DDLogVerbose(message)
    }

    func info(_ message: String) {
        DDLogInfo(message)
    }

    func warn(_ message: String) {
        DDLogWarn(message)
    }

    func debug(_ message: String) {
        DDLogDebug(message)
    }

    func error(_ message: String) {
        DDLogError(message)
    }
}
