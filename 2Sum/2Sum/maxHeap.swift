//
//  maxHeap.swift
//  2Sum
//
//  Created by Yevhen Herasymenko on 16/08/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

import Foundation

class MaxHeap {
    var value: Int
    var leftChild: MaxHeap!
    var rightChild: MaxHeap!
    
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
            self.leftChild = MaxHeap(value: object)
        } else if rightChild == nil {
            self.rightChild = MaxHeap(value: object)
        } else if leftChild.weight() > rightChild.weight() {
            self.rightChild.add(object)
        } else {
            self.leftChild.add(object)
        }
        stabilization()
    }
    
    func getMax() -> (max:Int, remove:Bool) {
        let result: Int = value
        var resultBool: Bool = false
        if leftChild == nil && rightChild == nil {
            resultBool = true
        } else if leftChild == nil {
            getMaxRight()
        } else if rightChild == nil {
            getMaxLeft()
        } else if leftChild.value > rightChild.value {
            getMaxLeft()
        } else {
            getMaxRight()
        }
        return (result, resultBool)
    }
    
    func getMaxRight() {
        let getMaxRight = rightChild.getMax()
        value = getMaxRight.max
        if getMaxRight.remove == true {
            rightChild = nil
        }
    }
    
    func getMaxLeft() {
        let getMaxLeft = leftChild.getMax()
        value = getMaxLeft.max
        if getMaxLeft.remove == true {
            leftChild = nil
        }
    }
    
    func stabilization() {
        if leftChild != nil && self.leftChild.value > value {
            var temp: Int = self.value
            self.value = leftChild.value
            leftChild.value = temp
        } else if  rightChild != nil && self.rightChild.value > value {
            var temp: Int = self.value
            self.value = rightChild.value
            rightChild.value = temp
        }
    }
}
