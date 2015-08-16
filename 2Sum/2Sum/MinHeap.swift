//
//  MinHeap.swift
//  2Sum
//
//  Created by Yevhen Herasymenko on 16/08/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

import Foundation

class MinHeap {
    var value: Int
    var leftChild: MinHeap!
    var rightChild: MinHeap!
    
    init(value: Int) {
        self.value = value
    }
    
    func weight() -> Int {
        var leftWeight: Int = leftChild == nil ? 0 : leftChild.weight()
        var rightWeight: Int = rightChild == nil ? 0 : rightChild.weight()
        return  leftWeight + rightWeight + 1
    }
    
    func add(object: Int) {
        if leftChild == nil {
            self.leftChild = MinHeap(value: object)
        } else if rightChild == nil {
            self.rightChild = MinHeap(value: object)
        } else if leftChild.weight() > rightChild.weight() {
            self.rightChild.add(object)
        } else {
            self.leftChild.add(object)
        }
        stabilization()
    }
    
    func getMin() -> (min:Int, remove:Bool) {
        let result: Int = value
        var resultBool: Bool = false
        if leftChild == nil && rightChild == nil {
            resultBool = true
        } else if leftChild == nil {
            getMinRight()
        } else if rightChild == nil {
            getMinLeft()
        } else if leftChild.value < rightChild.value {
            getMinLeft()
        } else {
            getMinRight()
        }
        return (result, resultBool)
    }
    
    func getMinRight() {
        let getMinRight = rightChild.getMin()
        value = getMinRight.min
        if getMinRight.remove == true {
            rightChild = nil
        }
    }
    
    func getMinLeft() {
        let getMinLeft = leftChild.getMin()
        value = getMinLeft.min
        if getMinLeft.remove == true {
            leftChild = nil
        }
    }
    
    func stabilization() {
        if leftChild != nil && self.leftChild.value < value {
            var temp: Int = self.value
            self.value = leftChild.value
            leftChild.value = temp
        } else if  rightChild != nil && self.rightChild.value < value {
            var temp: Int = self.value
            self.value = rightChild.value
            rightChild.value = temp
        }
    }
}