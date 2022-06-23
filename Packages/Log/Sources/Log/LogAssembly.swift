//
//  LogAssembly.swift
//  
//
//  Created by Vladislav Lisianskii on 13.11.2021.
//

import Foundation
import Swinject
import CocoaLumberjackSwift

public struct LogAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        container.register(Log.self) { (resolver: Resolver) -> Log in
            let log = Log()
            return log
        }
        .initCompleted { (_, log: Log) in
            log.initializeLoggers()
        }
        .implements(LogProtocol.self)
        .inObjectScope(.container)
    }
}
