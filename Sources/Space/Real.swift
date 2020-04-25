extension Real where Self: BinaryFloatingPoint, RawSignificand: FixedWidthInteger {
    
    @inlinable public static func random(
        in range: ClosedRange<Self>,
        median: Self,
        power exp: Self
    ) -> Self {
        random(in: range, median: median, by: { .pow($0, exp) })
    }
}


