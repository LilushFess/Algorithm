//
//  MidHeap.swift
//  2Sum
//
//  Created by Yevhen Herasymenko on 16/08/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

import Foundation

class MidHeap {
    var value: Int
    var leftChild: MaxHeap!
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
        if object == 1640 {
            println(" ")
        }
        if object >= value {
            if self.rightChild != nil {
                self.rightChild.add(object)
            } else {
                self.rightChild = MinHeap(value: object)
            }
        } else {
            if self.leftChild != nil {
                self.leftChild.add(object)
            } else {
                self.leftChild = MaxHeap(value: object)
            }
        }
        stabilization()
    }
    
    func stabilization() {
        if !(leftChild == nil && rightChild != nil && rightChild.weight() < 2) && !(rightChild == nil && leftChild != nil && leftChild.weight() < 2) {
            if leftChild == nil {
                leftChild = MaxHeap(value: value)
                self.value = rightChild.getMin().min
            } else if rightChild == nil {
                rightChild = MinHeap(value: value)
                self.value = leftChild.getMax().max
            }  else if rightChild.weight() - leftChild.weight() == 2 {
                leftChild.add(value)
                value = rightChild.getMin().min
            } else if leftChild.weight() - rightChild.weight() == 1 {
                rightChild.add(value)
                value = leftChild.getMax().max
            }
        }
    }
    
}
