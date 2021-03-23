import XCTest

final class CloneNryTreeTests: XCTestCase {
    
    func testTreeDescription() {
        let node = makeSUT()
        XCTAssertEqual(
            node.description,
            """
            1
            |   2
            |   |   4
            |   |   5
            |   3
            |   |   6
            |   |   7
            """
        )
    }
    func testCloneResucrsionHasSameDescription() {
        let node = makeSUT()
        let clone = node.cloneRecursion()
        XCTAssertEqual(node.description, clone.description)
    }
    
    func testCloneIterativeHasSameDescription() {
        let node = makeSUT()
        let clone = node.cloneIterative()
        XCTAssertEqual(node.description, clone.description)
    }
    func testCloneRecursionNodeAllDifferentFromOriginal() {
        let node = makeSUT()
        let set1 = collect(node)
        let clone = node.cloneRecursion()
        let set2 = collect(clone)
        set1.forEach {
             XCTAssertFalse(set2.contains($0))
        }
    }
    func testCloneIterativeNodeAllDifferentFromOriginal() {
        let node = makeSUT()
        let set1 = collect(node)
        let clone = node.cloneIterative()
        let set2 = collect(clone)
        set1.forEach {
             XCTAssertFalse(set2.contains($0))
        }
    }
    func testCollectTurlyCollectAllNode() {
        let node = makeSUT()
        let set = collect(node)
        XCTAssertEqual(set.count, 7)
    }
    
    // MARK: - helper
    private func makeSUT() -> Node {
        let node = Node(val: 1)
        node.addSubNode(Node(val: 2))
        node.addSubNode(Node(val: 3))
        node.subs[0].addSubNode(Node(val: 4))
        node.subs[0].addSubNode(Node(val: 5))
        node.subs[1].addSubNode(Node(val: 6))
        node.subs[1].addSubNode(Node(val: 7))
        return node
    }
    
    private func collect(_ node: Node) -> Set<ObjectIdentifier> {
        var set = Set<ObjectIdentifier>()
        func preorder(_ n: Node) {
            set.insert(ObjectIdentifier(n))
            for subn in n.subs {
                preorder(subn)
            }
        }
        preorder(node)
        return set
    }
    
}
extension Node {
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
