import XCTest

final class CloneNryTreeTests: XCTestCase {
    func testTreeDescription() {
        let node = Node(val: 1)
        node.subs.append(Node(val: 2))
        node.subs.append(Node(val: 3))
        node.subs[0].subs.append(Node(val: 4))
        node.subs[0].subs.append(Node(val: 5))
        node.subs[1].subs.append(Node(val: 6))
        node.subs[1].subs.append(Node(val: 7))
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
   
}
extension Node {
    func cloneRecursion() -> Node {
        let root = Node(val: self.val)
        for n in subs {
            let n2 = n.cloneRecursion()
            root.subs.append(n2)
            n2.parent = root
        }
        return root
    }
}




class Node:CustomStringConvertible {
    internal init(val: Int) {
        self.val = val
        self.subs = []
        self.parent = nil
    }
    
    var val: Int
    var subs:[Node]
    var parent:Node?

    private func treeLines() -> [String] {
        return [self.val.description] + self.subs.flatMap{$0.treeLines()}.map{"|   "+$0}
    }
    var description: String {
        treeLines().joined(separator: "\n")
    }
}
