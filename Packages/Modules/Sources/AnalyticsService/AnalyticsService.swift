import FirebaseAnalytics

final class AnalyticsService {
}

// MARK: - AnalyticsServiceProtocol
extension AnalyticsService: AnalyticsServiceProtocol {
    func logEvent(_ event: AnalyticsEvent) {
        FirebaseAnalytics.Analytics.logEvent(event.name, parameters: event.parameters)
    }
}
