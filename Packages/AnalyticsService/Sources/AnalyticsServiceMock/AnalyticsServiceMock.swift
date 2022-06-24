#if DEBUG
import AnalyticsService

public final class AnalyticsServiceMock {

    public init() { }

}

// MARK: - AnalyticsServiceProtocol
extension AnalyticsServiceMock: AnalyticsServiceProtocol {
    public func logEvent(_ event: AnalyticsEvent) {
    }
}
#endif
