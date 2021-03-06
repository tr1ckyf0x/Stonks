import Foundation

public enum CoinType: String, CaseIterable {
    case bitcoin
    case ethereum
    case solana
    case litecoin
    case bnb = "binance-coin"
    case monero
    case luna = "terra-luna"
    case tron

    public var description: String {
        switch self {
        case .bnb:
            return "BNB"

        case .luna:
            return "Luna"

        default:
            return rawValue.capitalized
        }
    }

    public var url: URL { URL(string: "https://coincap.io/assets/\(rawValue)")! }
}

extension CoinType: Identifiable {
    public var id: Self { self }
}

extension CoinType: Equatable {
    
}
