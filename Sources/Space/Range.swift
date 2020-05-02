extension ClosedRange: Real2D where Bound: Real {
    @inlinable public var tuple: (Bound, Bound) { (lowerBound, upperBound) }
    @inlinable public init(_ tuple: (Bound, Bound)) { self = tuple.0 ... tuple.1 }
    @inlinable public var range: ClosedRange<Bound> { self }
    @inlinable public var min: Bound { lowerBound }
    @inlinable public var max: Bound { upperBound }
}

extension ClosedRange where Bound: AdditiveArithmetic {
    @inlinable public var span: Bound { upperBound - lowerBound }
}

extension ClosedRange {
    public init(between: Bound, and: Bound) {
        self = between < and ? between ... and : and ... between
    }
}

extension ClosedRange {
    
    @inlinable public func clamped(to range: PartialRangeFrom<Bound>) -> Self {
        clamped(to: range.lowerBound ... Swift.max(upperBound, range.lowerBound))
    }
    
    @inlinable public func clamped(to range: PartialRangeThrough<Bound>) -> Self {
        clamped(to: Swift.min(lowerBound, range.upperBound) ... range.upperBound)
    }
}
