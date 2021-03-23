//
/* 
 *		Created by 游宗諭 in 2021/3/23
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 11.2
 */




class Node:CustomStringConvertible {
    internal init(val: Int) {
        self.val = val
        self.subs = []
        self.parent = nil
    }
    
    var val: Int
    private(set) var subs:[Node]
    private(set) var parent:Node?
    
    func addSubNode(_ node: Node) {
        subs.append(node)
        node.parent = self
    }

    private func treeLines() -> [String] {
        return [self.val.description] + self.subs.flatMap{$0.treeLines()}.map{"|   "+$0}
    }
    var description: String {
        treeLines().joined(separator: "\n")
    }
}
