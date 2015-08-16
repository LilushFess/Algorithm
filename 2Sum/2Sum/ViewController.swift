//
//  ViewController.swift
//  2Sum
//
//  Created by Yevhen Herasymenko on 16/08/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var path: String! = NSBundle.mainBundle().pathForResource("Median", ofType: "txt")
        var content: String! = (NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) as? String)!
        var arrayStrings: Array<String> = Array(content.componentsSeparatedByString("\r\n"))
        var array: Array<Int> = Array()
        
        for index in 0...arrayStrings.count-1 {
            array.append(arrayStrings[index].toInt()!)
        }

        var mid: Int = array[0]
        var midHeap: MidHeap = MidHeap(value: array[0])
        for index2 in 1...array.count-1 {
            midHeap.add(array[index2])
            mid += midHeap.value
        }
        mid = mid%10000
        println("\(mid)")
    }
    
    func sum2() {
        var path: String! = NSBundle.mainBundle().pathForResource("2sum", ofType: "txt")
        var content: String! = (NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) as? String)!
        var arrayStrings: Array<String> = Array(content.componentsSeparatedByString("\n"))
        var boolArray: Array<Bool> = Array()
        for index in -10000...10000 {
            boolArray.append(false)
        }
        var setArray: Set<String> = Set(arrayStrings)
        arrayStrings = Array(setArray)
        var array: Array<Int> = Array()
        
        for index in 0...arrayStrings.count-1 {
            array.append(arrayStrings[index].toInt()!)
        }
        
        array.sort({ $0 < $1 })
        
        var resultCounter: Int = 0
        while array.count > 1 {
            if array[0] > 10000 {
                break
            }
            while array[0] + array[array.count-1] > 10000 {
                array.removeLast()
            }
            for var index = array.count-1; index > 0; --index {
                var result: Int = array[0] + array[index]
                if result >= -10000 && result <= 10000 {
                    if boolArray[result + 10000] != true {
                        boolArray[result + 10000] = true
                        resultCounter++
                    }
                } else if (result < -10000) {
                    break
                }
                
            }
            array.removeAtIndex(0)
        }
        println("result: \(resultCounter)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

