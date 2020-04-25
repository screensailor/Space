public protocol Real4D: Equatable {
    associatedtype R: Real
    var tuple: (R, R, R, R) { get }
    init(_: (R, R, R, R))
}

