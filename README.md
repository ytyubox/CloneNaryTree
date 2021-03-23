# Clone Nary tree


A Nary tree can be describe as follow:
```
1
|   2
|   |   4
|   |   5
|   3
|   |   6
|   |   7
```

## By Recursion:
```swift
public extension Node {
    func cloneRecursion() -> Node {
        let root = Node(val: self.val)
        for n in subs {
            let n2 = n.cloneRecursion()
            root.addSubNode(n2)
        }
        return root
    }
}
```

## By Iterative

```swift
public extension Node {
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
```
