public struct LineSegment<Point>: LineSegmentInSpace
    where Point: PointInSpace
{
    public typealias R = Point.R

    public var start: Point
    public var end: Point
    
    public init(from start: Point = .zero, to end: Point = .zero) {
        self.start = start
        self.end = end
    }
}

public protocol LineSegmentInSpace {
    
    associatedtype R
    associatedtype Point: PointInSpace where Point.R == R
    
    var start: Point { get set }
    var end: Point { get set }
    
    init(from start: Point, to end: Point)
}

extension LineSegmentInSpace {
    @inlinable public func angle() -> R { start.angle(to: end) }
    @inlinable public func length() -> R { start.distance(to: end) }
    @inlinable public func slope() -> R { (end.y - start.y) / (end.x - start.x) }
    @inlinable public func xIntercept() -> R { -yIntercept() / slope() }
    @inlinable public func yIntercept() -> R { end.y - slope() * end.x }
}

extension LineSegmentInSpace {
    
    public func intersection(with other: Self) -> Point? {
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
        return Point((x, y))
    }
}

