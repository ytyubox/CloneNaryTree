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
}
