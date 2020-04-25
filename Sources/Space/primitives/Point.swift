public struct Point<R>: PointInSpace
    where R: Real
{
    public var x: R
    public var y: R
    
    public init(x: R = 0, y: R = 0) {
        self.x = x
        self.y = y
    }
}

public protocol PointInSpace: Real2D {
    
    var x: R { get set }
    var y: R { get set }
    
    init(x: R, y: R)
}

extension PointInSpace {
    @inlinable public var tuple: (R, R) { (x, y) }
    @inlinable public init(_ tuple: (R, R)) { self.init(x: tuple.0, y: tuple.1) }
}

extension PointInSpace {
    @inlinable public func angle(to other: Self) -> R { (other - self).direction() }
    @inlinable public func distance(to other: Self) -> R { (other - self).magnitude() }
}

extension PointInSpace {
    
    @inlinable public func point(at θ: R, distance: R) -> Self {
        .init(x: .cos(θ), y: .sin(θ)) * distance + self
    }
}

