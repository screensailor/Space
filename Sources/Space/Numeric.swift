extension Numeric where Self: SignedNumeric, Self: Comparable {
    
    @inlinable public static func ± (l: Self, r: Self) -> ClosedRange<Self> {
        (l - abs(r)) ... (l + abs(r))
    }
}

extension FloatingPoint {
    
    @inlinable public static var π: Self { .pi }
    
    @inlinable public var ifFinite: Self? { isFinite ? self : nil }
}
