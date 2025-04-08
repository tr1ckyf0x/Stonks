import FirebaseAnalytics

protocol AnalyticsServiceProtocol {
    func logEvent(_ event: AnalyticsEvent)
}

final class AnalyticsService {
    init() { }
}

// MARK: - AnalyticsServiceProtocol
extension AnalyticsService: AnalyticsServiceProtocol {
    func logEvent(_ event: AnalyticsEvent) {
        FirebaseAnalytics.Analytics.logEvent(event.name, parameters: event.parameters)
    }
}
