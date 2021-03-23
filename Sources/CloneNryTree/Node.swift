//
/* 
 *		Created by 游宗諭 in 2021/3/23
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 11.2
 */




public class Node:CustomStringConvertible {
    public init(val: Int) {
        self.val = val
        self.subs = []
        self.parent = nil
    }
    
    var val: Int
    public private(set) var subs:[Node]
    public private(set) var parent:Node?
    
    public func addSubNode(_ node: Node) {
        subs.append(node)
        node.parent = self
    }

    private func treeLines() -> [String] {
        return [self.val.description] + self.subs.flatMap{$0.treeLines()}.map{"|   "+$0}
    }
    public var description: String {
        treeLines().joined(separator: "\n")
    }
}


public extension Node {
    func cloneRecursion() -> Node {
        let root = Node(val: self.val)
        for n in subs {
            let n2 = n.cloneRecursion()
            root.addSubNode(n2)
        }
        return root
    }
    
    func cloneIterative() -> Node {
        let root = Node(val: val)
        var clone:Node? = root
        var original:Node? = self
        
        while true {
            guard let o = original, let c = clone else {break}
            if c.subs.count == o.subs.count {
                original = original?.parent
                clone = clone?.parent
                continue
            }
            let o2 = o.subs[c.subs.count]
            let c2 = Node(val: o2.val)
            c.addSubNode(c2)
            (original, clone) = (o2, c2)
        }
        return root
    }
}
