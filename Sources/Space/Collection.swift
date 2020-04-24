extension Sequence {
    
    @inlinable public func min<A: Comparable>(by keyPath: KeyPath<Element, A>) -> Element? {
        self.min{ $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
    
    @inlinable public func max<A: Comparable>(by keyPath: KeyPath<Element, A>) -> Element? {
        self.max{ $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
