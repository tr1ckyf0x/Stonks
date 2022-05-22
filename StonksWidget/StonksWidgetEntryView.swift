//
//  StonksWidgetEntryView.swift
//  StonksWidget
//
//  Created by Vladislav Lisianskii on 22.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import SwiftUI
import WidgetKit

struct StonksWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct StonksWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        StonksWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
