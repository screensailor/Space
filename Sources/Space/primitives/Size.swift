public struct Size<R>: SizeInSpace
    where R: Real
{
    public var width: R
    public var height: R
    
    public init(width: R = 0, height: R = 0) {
        self.width = width
        self.height = height
    }
}

public protocol SizeInSpace: Real2D {
    
    var width: R { get set }
    var height: R { get set }
    
    init(width: R, height: R)
}

extension SizeInSpace {
    @inlinable public var tuple: (R, R) { (width, height) }
    @inlinable public init(_ tuple: (R, R)) { self.init(width: tuple.0, height: tuple.1) }
}

extension SizeInSpace {
    @inlinable public init(square length: R) { self.init(width: length, height: length) }
}

extension SizeInSpace {
    @inlinable public var area: R { width * height }
}

extension SizeInSpace where R: BinaryFloatingPoint, R.RawSignificand: FixedWidthInteger {
    
    @inlinable public func randomPoint<Point>(_ type: Point.Type = Point.self) -> Point
        where Point: PointInSpace, Point.R == R
    {
        Point(
            x: .random(in: width < 0 ? width ... 0 : 0 ... width),
            y: .random(in: height < 0 ? height ... 0 : 0 ... height)
        )
    }
}

