import XCTest
import CloneNryTree

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
    func testNodeDestroyWillReleaseAllSubNode() {
        var node1:Node? = Node(val: 0)
        var node2:Node? = Node(val: 1)
        var node3:Node? = Node(val: 2)
        weak var w1 = node1
        weak var w2 = node2
        weak var w3 = node3
        node1?.addSubNode(node2!)
        node2?.addSubNode(node3!)
        node1?.destroy()
        node1 = nil
        node2 = nil
        node3 = nil
        XCTAssertNil(w1)
        XCTAssertNil(w2)
        XCTAssertNil(w3)
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
