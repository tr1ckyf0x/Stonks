import Foundation

enum CoinType: String, CaseIterable, Equatable {
    case bitcoin
    case ethereum
    case solana
    case litecoin
    case bnb = "binance-coin"
    case polygon
    case monero
    case near = "near-protocol"
    case twt = "trust-wallet-token"
    case tron

    var description: String {
        switch self {
        case .bnb:
            return "BNB"

        case .near:
            return "NEAR"

        case .twt:
            return "TWT"

        default:
            return rawValue.capitalized
        }
    }

    var url: URL { URL(string: "https://coincap.io/assets/\(rawValue)")! }
}

extension CoinType: Identifiable {
    var id: Self { self }
}
