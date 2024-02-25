import FirebaseAnalytics

public final class AnalyticsService {
    public init() { }
}

// MARK: - AnalyticsServiceProtocol
extension AnalyticsService: AnalyticsServiceProtocol {
    public func logEvent(_ event: AnalyticsEvent) {
        FirebaseAnalytics.Analytics.logEvent(event.name, parameters: event.parameters)
    }
}
