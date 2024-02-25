import Sparkle

public final class UpdateService {
    private let updaterController: SPUStandardUpdaterController

    public init(updaterController: SPUStandardUpdaterController) {
        self.updaterController = updaterController
    }
}

extension UpdateService: UpdateServiceProtocol {
    public func checkForUpdates() {
        updaterController.checkForUpdates(self)
    }
}
