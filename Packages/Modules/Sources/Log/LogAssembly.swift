//
//  LogAssembly.swift
//  
//
//  Created by Vladislav Lisianskii on 13.11.2021.
//

import CocoaLumberjackSwift
import Foundation
import Swinject

public struct LogAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        container.register(Log.self) { _ -> Log in
            Log()
        }
        .initCompleted { (_, log: Log) in
            log.initializeLoggers()
        }
        .implements(LogProtocol.self)
        .inObjectScope(.container)
    }
}
