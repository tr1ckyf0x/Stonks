//
//  StonksWidget.swift
//  StonksWidget
//
//  Created by Vladislav Lisianskii on 22.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
struct StonksWidget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            StonksWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
