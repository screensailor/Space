public struct Ellipse<Point>: EllipseInSpace
    where Point: PointInSpace
{
    public typealias R = Point.R
    
    public var center: Point
    
    public var xRadius: R
    public var yRadius: R
    
    public init(center: Point = .zero, xRadius: R, yRadius: R) {
        self.center = center
        self.xRadius = xRadius
        self.yRadius = yRadius
    }
}

public protocol EllipseInSpace {
    
    associatedtype R
    associatedtype Point: PointInSpace where Point.R == R
    
    var center: Point { get set }
    
    var xRadius: R { get set }
    var yRadius: R { get set }
    
    init(center: Point, xRadius: R, yRadius: R)
}

extension EllipseInSpace {
    @inlinable public var xDiameter: R { xRadius * 2 }
    @inlinable public var yDiameter: R { yRadius * 2 }
}

