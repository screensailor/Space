public struct Circle<Point>: CircleInSpace
    where Point: PointInSpace
{
    public typealias R = Point.R
    
    public var center: Point
    public var radius: R
    
    public init(center: Point = .zero, radius: R = 0) {
        self.center = center
        self.radius = radius
    }
}

public protocol CircleInSpace {
    
    associatedtype R
    associatedtype Point: PointInSpace where Point.R == R
    
    var center: Point { get set }
    var radius: R { get set }
    
    init(center: Point, radius: R)
}

extension CircleInSpace {
    
    @inlinable public func scaled(to scale: R) -> Self {
        .init(center: center, radius: radius * scale)
    }

    @inlinable public func contains(_ point: Point) -> Bool {
        point.distance(to: center) <= radius
    }
    
    @inlinable public func point(at θ: R) -> Point {
        Point(x: .cos(θ), y: .sin(θ)) * radius + center
    }
}

extension CircleInSpace where R.Stride == R {
    
    public func points(count: Int, startingFrom θ: R = 0) -> [Point] {
        count > 0 ? stride(from: θ, to: θ + 2 * .π, by: 2 * .π / R(count)).map(point(at:)) : []
    }
}

extension CircleInSpace where R: BinaryFloatingPoint, R.RawSignificand: FixedWidthInteger {
    
    @inlinable public func randomPoint(in range: ClosedRange<R> = 1 ± .π) -> Point {
        point(at: .random(in: range))
    }
}

