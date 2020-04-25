public protocol Real4D: Equatable {
    associatedtype D: Real
    var tuple: (D, D, D, D) { get }
    init(_: (D, D, D, D))
}

