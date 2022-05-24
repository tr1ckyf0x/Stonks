//
//  StonksWidgetView.swift
//  StonksWidget
//
//  Created by Vladislav Lisianskii on 22.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import SwiftUI
import WidgetKit
import SharedResources

struct StonksWidgetView: View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        ZStack {
            Image(nsImage: Asset.Assets.Images.stonks.image)
                .resizable()
                .unredacted()
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    header()
                    Spacer()
                    pricing()
                    Spacer()
                }
            }
            .padding()
        }
    }

    private func header() -> some View {
        let font: Font = family == .systemLarge ?
            .system(size: 40) :
            .title

        let title: String
        switch entry.change {
        case .increase:
            title = L10n.Widget.Title.stonks

        case .decrease:
            title = L10n.Widget.Title.notStonks
        }
        return Group {
            Text(title)
                .bold()
                .font(font)
                .minimumScaleFactor(0.3)
            Text(entry.currencyName)
                .font(family == .systemLarge ? .title : .headline)
                .padding(.top, family == .systemLarge ? -15 : 0)
        }
        .foregroundColor(Color(nsColor: Asset.Colors.heading.color))
    }

    private func pricing() -> some View {
        Group {
            price()
            difference()
        }
    }

    private func price() -> some View {
        let price = priceNumberFormatter.string(
            from: NSNumber(value: entry.price)
        ) ?? L10n.Widget.Price.noData

        let font: Font
        switch family {
        case .systemSmall, .systemMedium:
            font = .system(size: 36)

        case .systemLarge:
            font = .system(size: 62)

        @unknown default:
            font = .system(size: 36)
        }

        return Text(price)
            .bold()
            .foregroundColor(.white)
            .font(font)
            .minimumScaleFactor(0.5)
    }

    private func difference() -> some View {
        let differenceValue = percentNumberFormatter.string(
            from: NSNumber(value: entry.change.value)
        ) ?? L10n.Widget.Price.noData
        let color: NSColor
        switch entry.change {
        case .increase:
            color = Asset.Colors.increase.color

        case .decrease:
            color = Asset.Colors.decrease.color
        }

        let font: Font
        switch family {
        case .systemSmall, .systemMedium:
            font = .system(size: 20)

        case .systemLarge:
            font = .system(size: 28)

        @unknown default:
            font = .system(size: 28)
        }

        return Text(differenceValue)
            .bold()
            .foregroundColor(Color(nsColor: color))
            .font(font)
    }

    private var priceNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }

    private var percentNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.multiplier = 1
        numberFormatter.numberStyle = NumberFormatter.Style.percent
        return numberFormatter
    }
}

struct StonksWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let decreaseEntry = StonksEntry(
            date: Date(),
            currencyName: "Bitcoin",
            price: 30000,
            change: .decrease(value: -10.53)
        )

        let increaseEntry = StonksEntry(
            date: Date(),
            currencyName: "Bitcoin",
            price: 30000,
            change: .increase(value: 10.53)
        )
        
        return Group {
            Group {
                StonksWidgetView(entry: decreaseEntry)
                    .previewContext(WidgetPreviewContext(family: .systemSmall))
                StonksWidgetView(entry: decreaseEntry)
                    .previewContext(WidgetPreviewContext(family: .systemMedium))
                StonksWidgetView(entry: decreaseEntry)
                    .previewContext(WidgetPreviewContext(family: .systemLarge))
            }
            Group {
                StonksWidgetView(entry: increaseEntry)
                    .previewContext(WidgetPreviewContext(family: .systemSmall))
                StonksWidgetView(entry: increaseEntry)
                    .previewContext(WidgetPreviewContext(family: .systemMedium))
                StonksWidgetView(entry: increaseEntry)
                    .previewContext(WidgetPreviewContext(family: .systemLarge))
            }
        }
    }
}
