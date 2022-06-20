public struct Coin {
    let type: CoinType
    let value: Double

    public init(
        type: CoinType,
        value: Double
    ) {
        self.type = type
        self.value = value
    }
}
