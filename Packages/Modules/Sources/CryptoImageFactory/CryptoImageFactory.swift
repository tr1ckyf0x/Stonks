import MenuBarModels
import MenuBarResources

public enum CryptoImageFactory {
    public static func asset(for coinType: CoinType) -> MenuBarResources.ImageAsset {
        switch coinType {
        case .bitcoin:
            return Asset.Logo.bitcoin

        case .ethereum:
            return Asset.Logo.ethereum

        case .solana:
            return Asset.Logo.solana

        case .litecoin:
            return Asset.Logo.litecoin

        case .bnb:
            return Asset.Logo.bnb

        case .polygon:
            return Asset.Logo.polygon

        case .monero:
            return Asset.Logo.monero

        case .near:
            return Asset.Logo.near

        case .twt:
            return Asset.Logo.twt

        case .luna:
            return Asset.Logo.luna

        case .tron:
            return Asset.Logo.tron
        }
    }
}
