import FirebaseAnalytics

public enum AnalyticsEvent {
    case appOpen
    case selectedCoin(_ coin: String)
    case pressedCheckForUpdates
}

extension AnalyticsEvent {
    var name: String {
        switch self {
        case .appOpen:
            return AnalyticsEventAppOpen

        case .selectedCoin:
            return "selected_coin"

        case .pressedCheckForUpdates:
            return "pressed_check_updates"
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .appOpen, .pressedCheckForUpdates:
            return nil

        case let .selectedCoin(coin):
            return ["coin": coin]
        }
    }
}
