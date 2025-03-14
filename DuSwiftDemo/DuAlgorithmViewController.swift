//
//  DuAlgorithmViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/2/18.
//

import UIKit

// MARK: - LinkNode
class LinkNode {
    var val: Int
    var next: LinkNode?
    init(val: Int, next: LinkNode? = nil) {
        self.val = val
        self.next = next
    }
}

extension LinkNode {
    static func mockLinkNode(_ values: [Int]) -> LinkNode? {
        guard !values.isEmpty else { return nil }
        let headNode: LinkNode = LinkNode(val: -1)
        var currentNode: LinkNode? = headNode
        values.forEach { value in
            currentNode?.next = LinkNode(val: value)
            currentNode = currentNode?.next ?? nil
        }
        return headNode.next
    }
    
    static func printLinkNode(_ head: LinkNode?) {
        var currentNode: LinkNode? = head
        while currentNode != nil {
            print("link node value: \(currentNode?.val ?? 0)")
            currentNode = currentNode?.next
        }
    }
}

extension LinkNode {
    func reversedLinkNode(_ head: LinkNode?) -> LinkNode? {
        var pre: LinkNode? = nil
        var current: LinkNode? = head
        while current != nil {
            let next: LinkNode? = current?.next
            current?.next = pre
            pre = current
            current = next
        }
        return pre
    }
}



// MARK: - TreeNode
class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

// 二叉树
class BinaryTree {
    var root: TreeNode?
    init(root: TreeNode? = nil) {
        self.root = root
    }
}

extension BinaryTree {
    
    /// 是否是满二叉树
    /// 如果树为空，它是满二叉树；如果是叶子节点，它也是满二叉树；如果一个节点有两个子节点，并且左右子树都是满二叉树，那么该节点是满二叉树的一部分；否则，它就不是满二叉树。
    /// - Parameter node: 节点
    /// - Returns: true or false
    func isFullBinaryTree(node: TreeNode?) -> Bool {
        guard let node = node else { return true }
        // 如果是叶子节点
        if node.left == nil && node.right == nil {
            return true
        }
        if let left = node.left, let right = node.right {
            return isFullBinaryTree(node: left) && isFullBinaryTree(node: right)
        }
        return false
    }
    
    
    /// 是否是完全二叉树
    /// 我们使用广度优先搜索（BFS）遍历树，并在遇到第一个 nil 节点时标记为已到达末尾。如果在标记末尾之后遇到非 nil 节点，则树不是完全二叉树。否则，树是完全二叉树。
    /// - Parameter node: 节点
    /// - Returns: true or false
    func isCommpleteBinaryTree(node: TreeNode?) -> Bool {
        guard let root = node else { return true }
        var queue: [TreeNode?] = [root]
        // 标记是否已到达末尾
        var reachedEnd = false
        while !queue.isEmpty {
            let currentNode = queue.removeFirst()
            if let currentNode = currentNode {
                if reachedEnd {
                    return false
                }
                queue.append(currentNode.left)
                queue.append(currentNode.right)
            } else {
                reachedEnd = true
            }
        }
        return true
    }
    
    
    /// 是否是平衡二叉树 AVL
    /// 用于递归检查每个节点是否满足平衡二叉树的条件。我们通过一个辅助函数 checkHeight 计算每个节点的高度，如果发现任何节点的左右子树高度差超过1，则返回 -1，表示树不是平衡二叉树。否则，返回树的高度。
    /// - Parameter node: 节点
    /// - Returns: true or false
    func isBalancedBinaryTree(node: TreeNode?) -> Bool {
        return checkHeight(node) != -1
    }
    
    func checkHeight(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        let leftHeight = checkHeight(node.left)
        if leftHeight == -1 {
            return -1
        }
        
        let rightHeight = checkHeight(node.right)
        if rightHeight == -1 {
            return -1
        }
        
        if abs(leftHeight - rightHeight) > 1 {
            return -1
        } else {
            return max(leftHeight, rightHeight) + 1
        }
    }
    
    
    /// 二叉树深度
    /// - Parameter node: 节点
    /// - Returns: 深度
    func depth(node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        let leftDepth = depth(node: node.left)
        let rightDepth = depth(node: node.right)
        return max(leftDepth, rightDepth) + 1
    }
    
    func isSymmetric(node: TreeNode?) -> Bool {
        return isMirror(node, node)
    }
    
    // 是否是镜像
    func isMirror(_ t1: TreeNode?, _ t2: TreeNode?) -> Bool {
        if t1 == nil && t2 == nil {
            return true
        }
        
        if t1 == nil || t2 == nil {
            return false
        }
        
        return (t1?.val == t2?.val) && isMirror(t1?.left, t2?.right) && isMirror(t1?.right, t2?.left)
    }
}



typealias Operation = (Int, Int) -> Int

class DuAlgorithmViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testSort()
    }
    
    func testSort() {
        var numbers = [10,5,18,11,7,22,35,29,67]
        insertionSort(&numbers)
    }
    
    func testLinkList() {
        let values = [1, 2, 3, 4, 5, 6, 7]
        let head = LinkNode.mockLinkNode(values)
        LinkNode.printLinkNode(head)
    }
    
    func testTreeNode() {
        let rootNode = TreeNode(val: 1)
        let leftNode = TreeNode(val: 2)
        let rightNode = TreeNode(val: 3)
        rootNode.left = leftNode
        rootNode.right = rightNode
        
        
        let node1 = TreeNode(val: 4)
        let node2 = TreeNode(val: 5)
        leftNode.left = node1
        node1.right = node2
        
        let node3 = TreeNode(val: 6)
        let node4 = TreeNode(val: 7)
        rootNode.left = node3
        rightNode.right = node4
     
        let tree = BinaryTree(root: rootNode)
        print(tree.depth(node: rootNode))
    }
    
    func testFunction() {
        testMore(1,2,3)
        testMore(1,2,3,4)
        
        var firstNumber = "Hello"
        var secondNumber = "World"
        
        print("firstNumber: \(firstNumber) secondNumber: \(secondNumber)")
     
        swapTowInts(&firstNumber, &secondNumber)
        
        print("firstNumber: \(firstNumber) secondNumber: \(secondNumber)")
    }
    
    
    func testMore(_ values: Int...) {
        print("\(values)")
    }
    
    func performOperation(_ a: Int, _ b: Int, operatioin: Operation) -> Int {
        return operatioin(a, b)
    }
    
    func makeIncrementer(incrementAmount: Int) -> () -> Int {
        var total = 0
        let incrementer: () -> Int = {
            total += incrementAmount
            return total
        }
        return incrementer
    }
    
    //MARK: - 数据结构
    func isFullBinaryTree(_ root: TreeNode?) -> Bool {
        return true
    }
    

    func binarySearch<T: Comparable>(_ array: [T], target: T) -> Int? {
        var left = 0
        var right = array.count - 1
        while left <= right {
            let mid = (left + right) / 2
            if array[mid] == target {
                return mid
            } else if array[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return nil
    }
    
    func swapTowInts<T>(_ a: inout T, _ b: inout T) {
        let temp = a
        a = b
        b = temp
    }
}

extension DuAlgorithmViewController {
    func minSubArray(target: Int, array: [Int]) -> Int {
        let n = array.count
        var ans = n + 1
        return ans
    }
    
    func climbStairs(_ stairsNumber: Int) -> Int{
        if stairsNumber == 1 {
            return 1
        }
        
        if stairsNumber == 2 {
            return 2
        }
        return climbStairs(stairsNumber - 1) + climbStairs(stairsNumber - 2)
    }
    
    func mergeSortArray(_ array1: [Int], _ array2: [Int]) -> [Int] {
      
        var result: [Int] = []
        var i = 0
        var j = 0
        while i < array1.count && j < array2.count {
            if array1[i] <= array2[j] {
                result.append(array1[i])
                i += 1
            } else {
                result.append(array2[j])
                j += 1
            }
        }
        
        if i < array1.count {
            result.append(contentsOf: array1[i...])
        }
        
        if j < array2.count {
            result.append(contentsOf: array2[j...])
        }
        
        return result
    }
}



indirect enum LinkedList<Element> {
    case empty
    case node(Element, LinkedList<Element>)
    
    var length: Int {
        switch self {
        case .empty:
            return 0
        case .node(_, let next):
            return 1 + next.length
        }
    }
    
    func printList() {
        switch self {
        case .empty:
            print("End")
        case .node(let element, let next):
            print(element)
            next.printList()
        }
    }
    
    mutating func append(_ newElement: Element) {
        switch self {
        case .empty:
            self = .node(newElement, .empty)
        case .node(let element, var next):
            next.append(newElement)
            self = .node(element, next)
        }
    }
}

// MARK: - Sort Algorithm

extension DuAlgorithmViewController {
    func insertionSort(_  numbers: inout [Int]) {
        let count = numbers.count
        for i in 1..<count {
            let key = numbers[i]
            var j = i - 1
            while j >= 0 && numbers[j] > key {
                numbers[j + 1] = numbers[j]
                j -= 1
            }
            numbers[j + 1] = key
        }
        print("numbers: \(numbers)")
    }
}

extension DuAlgorithmViewController {
    func moveZero(_ numbers: inout [Int]) {
        
    }
    
    // 常量 字面量
    // 避免冲突 不能将同一个变量传递给多个inout参数
}
