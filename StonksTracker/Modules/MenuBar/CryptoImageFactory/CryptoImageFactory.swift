enum CryptoImageFactory {
    static func asset(for coinType: CoinType) -> ImageResource {
        switch coinType {
        case .bitcoin:
            return .bitcoin

        case .ethereum:
            return .ethereum

        case .solana:
            return .solana

        case .litecoin:
            return .litecoin

        case .bnb:
            return .bnb

        case .polygon:
            return .polygon

        case .monero:
            return .monero

        case .near:
            return .near

        case .twt:
            return .twt

        case .tron:
            return .tron
        }
    }
}
