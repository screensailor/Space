public protocol CircleSpace {
    associatedtype Point: PointInSpace where Self.Point.D == Self
}

extension CircleSpace where Self: Real {
    public typealias Point = Space.Point<Self>
}

extension Float: CircleSpace {}
extension Double: CircleSpace {}

public struct Circle<In: CircleSpace>: CircleInSpace {
    
    public typealias D = In
    public typealias Point = In.Point
    
    public var center: Point
    public var radius: D
    
    public init(center: Point = .zero, radius: D = 0) {
        self.center = center
        self.radius = radius
    }
}

public protocol CircleInSpace {
    
    associatedtype D
    associatedtype Point: PointInSpace where Point.D == D
    
    var center: Point { get set }
    var radius: D { get set }
    
    init(center: Point, radius: D)
}

extension CircleInSpace {
    
    @inlinable public var diameter: D { radius * 2 }
    
    @inlinable public func size<A>() -> A where A: SizeInSpace, A.D == D {
        A(width: radius * 2, height: radius * 2)
    }
}

extension CircleInSpace {
    
    @inlinable public func scaled(to scale: D) -> Self {
        .init(center: center, radius: radius * scale)
    }

    @inlinable public func contains(_ point: Point) -> Bool {
        point.distance(to: center) <= radius
    }
    
    @inlinable public func point<A>(at θ: D) -> A where A: PointInSpace, A.D == D {
        A(x: .cos(θ), y: .sin(θ)) * radius + center
    }
}

extension CircleInSpace where D.Stride == D {
    
    public func points<A>(count: Int, startingFrom θ: D = 0) -> [A] where A: PointInSpace, A.D == D {
        count > 0 ? stride(from: θ, to: θ + 2 * .π, by: 2 * .π / D(count)).map(point(at:)) : []
    }
}

extension CircleInSpace where D: BinaryFloatingPoint, D.RawSignificand: FixedWidthInteger {
    
    @inlinable public func randomPoint<A>(in range: ClosedRange<D> = 1 ± .π) -> A where A: PointInSpace, A.D == D {
        point(at: .random(in: range))
    }
}

