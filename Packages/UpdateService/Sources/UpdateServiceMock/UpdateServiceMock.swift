#if DEBUG
import UpdateService

public final class UpdateServiceMock {
    public init() { }
}

extension UpdateServiceMock: UpdateServiceProtocol {
    public func checkForUpdates() {
    }
}
#endif
