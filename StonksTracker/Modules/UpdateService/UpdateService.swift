import Sparkle

final class UpdateService {
    private let updaterController: SPUStandardUpdaterController

    init(updaterController: SPUStandardUpdaterController) {
        self.updaterController = updaterController
    }
}

extension UpdateService: UpdateServiceProtocol {
    func checkForUpdates() {
        updaterController.checkForUpdates(self)
    }
}
