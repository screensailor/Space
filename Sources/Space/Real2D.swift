public protocol Real2D: Equatable, CustomDebugStringConvertible {
    
    associatedtype R: Real
    
    /// required:
    var tuple: (R, R) { get }
    init(_ tuple: (R, R))
    
    /// optional:
    var range: ClosedRange<R> { get }
    var min: R { get }
    var max: R { get }
}

extension Real2D {
    @inlinable public var range: ClosedRange<R> { min ... max }
    @inlinable public var min: R { tuple.0 < tuple.1 ? tuple.0 : tuple.1 }
    @inlinable public var max: R { tuple.0 > tuple.1 ? tuple.0 : tuple.1 }
}

extension Real2D {
    @inlinable public init<A: Real2D>(_ a: A) where A.R == R { self.init(a.tuple) }
    @inlinable public func cast<A: Real2D>(to: A.Type = A.self) -> A where A.R == R { A.init(tuple) }
}

extension Real2D {
    public static func == (l: Self, r: Self) -> Bool { l.tuple == r.tuple }
    public var debugDescription: String { "\(Self.self)(\(tuple.0), \(tuple.1))" }
}

extension Real2D {
    @inlinable public static var zero: Self { .init((0, 0)) }
    @inlinable public static var unit: Self { .init((1, 1)) }
}

extension Real2D {
    @inlinable public var isFinite: Bool { tuple.0.isFinite && tuple.1.isFinite }
}

extension Real2D {
    @inlinable public prefix static func - (o: Self) -> Self { o.map{ -$0 } }
}

extension Real2D {
    @inlinable public static func + (l: Self, r: R) -> Self { l.map{ $0 + r } }
    @inlinable public static func - (l: Self, r: R) -> Self { l.map{ $0 - r } }
    @inlinable public static func * (l: Self, r: R) -> Self { l.map{ $0 * r } }
    @inlinable public static func / (l: Self, r: R) -> Self { l.map{ $0 / r } }
}

extension Real2D {
    @inlinable public static func += (l: inout Self, r: R) { l = l + r }
    @inlinable public static func -= (l: inout Self, r: R) { l = l - r }
    @inlinable public static func *= (l: inout Self, r: R) { l = l * r }
    @inlinable public static func /= (l: inout Self, r: R) { l = l / r }
}

extension Real2D {
    @inlinable public static func + (l: Self, r: (R, R)) -> Self { self.init( (l.tuple.0 + r.0, l.tuple.1 + r.1) ) }
    @inlinable public static func - (l: Self, r: (R, R)) -> Self { self.init( (l.tuple.0 - r.0, l.tuple.1 - r.1) ) }
    @inlinable public static func * (l: Self, r: (R, R)) -> Self { self.init( (l.tuple.0 * r.0, l.tuple.1 * r.1) ) }
    @inlinable public static func / (l: Self, r: (R, R)) -> Self { self.init( (l.tuple.0 / r.0, l.tuple.1 / r.1) ) }
}

extension Real2D {
    @inlinable public static func += (l: inout Self, r: (R, R)) { l = l + r }
    @inlinable public static func -= (l: inout Self, r: (R, R)) { l = l - r }
    @inlinable public static func *= (l: inout Self, r: (R, R)) { l = l * r }
    @inlinable public static func /= (l: inout Self, r: (R, R)) { l = l / r }
}

extension Real2D {
    @inlinable public static func + <A: Real2D>(l: Self, r: A) -> Self where A.R == R { self.init( (l.tuple.0 + r.tuple.0, l.tuple.1 + r.tuple.1) ) }
    @inlinable public static func - <A: Real2D>(l: Self, r: A) -> Self where A.R == R { self.init( (l.tuple.0 - r.tuple.0, l.tuple.1 - r.tuple.1) ) }
    @inlinable public static func * <A: Real2D>(l: Self, r: A) -> Self where A.R == R { self.init( (l.tuple.0 * r.tuple.0, l.tuple.1 * r.tuple.1) ) }
    @inlinable public static func / <A: Real2D>(l: Self, r: A) -> Self where A.R == R { self.init( (l.tuple.0 / r.tuple.0, l.tuple.1 / r.tuple.1) ) }
}

extension Real2D {
    @inlinable public static func += <A: Real2D>(l: inout Self, r: A) where A.R == R { l = l + r }
    @inlinable public static func -= <A: Real2D>(l: inout Self, r: A) where A.R == R { l = l - r }
    @inlinable public static func *= <A: Real2D>(l: inout Self, r: A) where A.R == R { l = l * r }
    @inlinable public static func /= <A: Real2D>(l: inout Self, r: A) where A.R == R { l = l / r }
}

extension Real2D {
    @inlinable public func map(_ ƒ: (R) -> R) -> Self { Self( (ƒ(tuple.0), ƒ(tuple.1)) ) }
    @inlinable public func magnitude() -> R { R.hypot(tuple.0, tuple.1) }
    @inlinable public func direction() -> R { R.atan2(y: tuple.1, x: tuple.0) }
    @inlinable public func sorted(_ areSorted: (R, R) -> Bool) -> Self {
        areSorted(tuple.0, tuple.1) ? self : .init((tuple.1, tuple.0))
    }
}

extension Real2D {
    
    @inlinable public func crossProduct<A: Real2D>(with a: A) -> R
        where A.R == R
    {
        tuple.0 * a.tuple.1 - tuple.1 * a.tuple.0
    }
    
    @inlinable public func crossProduct<A: Real2D, B: Real2D>(with a: A, relativeTo b: B) -> R
        where A.R == R, B.R == R
    {
        (self - b).crossProduct(with: a - b)
    }
}
