public struct LineSegment<Point: PointInSpace>: LineSegmentInSpace {
    
    public var start: Point
    public var end: Point
    
    public init(from start: Point = .zero, to end: Point = .zero) {
        self.start = start
        self.end = end
    }
}

public protocol LineSegmentInSpace {
    
    associatedtype Point: PointInSpace
    
    var start: Point { get set }
    var end: Point { get set }
    
    init(from start: Point, to end: Point)
}

extension LineSegmentInSpace {
    public typealias D = Point.D
}

extension LineSegmentInSpace {
    @inlinable public func angle() -> D { start.angle(to: end) }
    @inlinable public func length() -> D { start.distance(to: end) }
    @inlinable public func slope() -> D { (end.y - start.y) / (end.x - start.x) }
    @inlinable public func xIntercept() -> D { -yIntercept() / slope() }
    @inlinable public func yIntercept() -> D { end.y - slope() * end.x }
}

extension LineSegmentInSpace {
    
    public func intersection<A>(with other: Self) -> A? where A: PointInSpace, A.D == D {
        let (a, b, c, d) = (slope(), yIntercept(), other.slope(), other.yIntercept())
        let x = (d - b) / (a - c)
        let y = a * x + b
        guard
            x.isFinite,
            y.isFinite,
            x.isBetween(start.x, and: end.x),
            x.isBetween(other.start.x, and: other.end.x)
            else
        { return nil }
        return A(x: x, y: y)
    }
}

