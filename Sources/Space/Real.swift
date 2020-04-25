extension Real where Self: BinaryFloatingPoint, Self.RawSignificand: FixedWidthInteger {
    
    @inlinable public static func random(between: Self, and: Self) -> Self {
        .random(in: between < and ? between...and : and...between)
    }
}
