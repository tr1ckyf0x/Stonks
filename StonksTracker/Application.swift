//
//  Application.swift
//  StonksTracker
//
//  Created by Vladislav Lisianskii on 06.06.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import AppKit

final class Application: NSApplication {

    private let strongDelegate = AppDelegate()

    override init() {
        super.init()
        self.delegate = strongDelegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
