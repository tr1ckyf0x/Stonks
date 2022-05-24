//
//  Provider.swift
//  StonksWidget
//
//  Created by Vladislav Lisianskii on 22.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import WidgetKit

struct Provider: TimelineProvider {

    private let interactor: StonksWidgetInteractorProtocol

    init(stonksWidgetInteractor: StonksWidgetInteractorProtocol) {
        self.interactor = stonksWidgetInteractor
    }

    typealias Entry = StonksEntry

    func placeholder(in context: Context) -> Entry {
        placeholderEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        completion(placeholderEntry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let entries: [Entry]

            do {
                let stonksEntry = try await interactor.fetchStonksEntry()
                entries = [stonksEntry]
            } catch {
                entries = []
            }

            let policy: TimelineReloadPolicy
            if let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) {
                policy = .after(nextUpdateDate)
            } else {
                policy = .never
            }

            let timeline = Timeline(entries: entries, policy: policy)
            completion(timeline)
        }
    }
}

// MARK: - Private methods
extension Provider {
    private var placeholderEntry: Entry {
        StonksEntry(
            date: Date(),
            currencyName: L10n.Widget.Currency.placeholder,
            price: 30000,
            change: .increase(value: 0)
        )
    }
}
