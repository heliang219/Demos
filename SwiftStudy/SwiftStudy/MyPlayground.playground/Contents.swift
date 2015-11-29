//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

func changeValues(inout a:Int, inout _ b:Int) {
    let t = a
    a = b
    b = t
}

var a = 2
var b = 3
changeValues(&a, &b)
a
b

func changeValues2<T>(inout a1:T,inout _ b1:T) {
    let t = a1
    a1 = b1
    b1 = t
}

var a1 = "hahh"
var b1 = "hello"
changeValues2(&a1, &b1)
a1
b1

class A:NSObject {
    
}
A().dynamicType
A.self