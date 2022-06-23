//
//  LogProtocol.swift
//  
//
//  Created by Vladislav Lisianskii on 13.11.2021.
//

import Foundation

public protocol LogProtocol {
    func verbose(_ message: String)
    func info(_ message: String)
    func warn(_ message: String)
    func debug(_ message: String)
    func error(_ message: String)
}
