extension ClosedRange where Bound: AdditiveArithmetic {
    @inlinable public var size: Bound { upperBound - lowerBound }
}

extension ClosedRange {
    
    @inlinable public func clamped(to range: PartialRangeFrom<Bound>) -> Self {
        clamped(to: range.lowerBound ... Swift.max(upperBound, range.lowerBound))
    }
    
    @inlinable public func clamped(to range: PartialRangeThrough<Bound>) -> Self {
        clamped(to: Swift.min(lowerBound, range.upperBound) ... range.upperBound)
    }
}
