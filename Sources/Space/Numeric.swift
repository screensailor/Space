extension SignedNumeric where Self: Comparable {
    
    @inlinable public static func ± (l: Self, r: Self) -> ClosedRange<Self> {
        (l - abs(r)) ... (l + abs(r))
    }
}

extension FloatingPoint {
    
    @inlinable public static var π: Self { .pi }

    @inlinable public var ifFinite: Self? { isFinite ? self : nil }
}

extension BinaryFloatingPoint {
    @inlinable public var i: Int { Int(self) }
    @inlinable public var f: Float { Float(self) }
    @inlinable public var d: Double { Double(self) }
}

extension BinaryFloatingPoint where RawSignificand: FixedWidthInteger {
    
    @inlinable public static func random(between: Self, and: Self) -> Self {
        .random(in: between < and ? between...and : and...between)
    }
}

extension BinaryFloatingPoint where RawSignificand: FixedWidthInteger {
    
    public static func random(
        in range: ClosedRange<Self>,
        median: Self,
        by unitDistribution: (Self) -> Self
    ) -> Self {
        let o = (median.clamped(to: range) - range.lowerBound) / range.span // TODO: check for 0
        let x = unitDistribution(random(in: 0...1))
        let l = range.lowerBound + o * range.span
        return (1 - x) * l + x * (Bool.random() ? range.upperBound : range.lowerBound)
    }
}
