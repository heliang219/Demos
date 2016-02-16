//
//  main.swift
//  swiftDemo
//
//  Created by pfl on 15/5/20.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import Foundation

print("Hello, World!")

//class ClassA {
//    let numA: Int
//    
//   required init(num: Int)
//    {
//        numA = num//3
//    }
//    
//    convenience required init(bigNum: Bool)
//    {
//        self.init(num: bigNum ? 1000 : 1)//1
//        println(self)//5
//    }
//    
//    func prin()
//    {
//        println(numA)
//    }
//    
//    
//}
//
//
//class ClassB: ClassA {
//    let numB: Int
//     required init(num: Int) {
//        
//        // MARK: 如果numB是未初始化必须注意下面两句代码位置
//        
//        numB = num + 2//4
//        super.init(num: num)//2
//        
//    }
//    
//    func print()
//    {
//        
//        println(numB)
//    }
//    
//    
//}
//
//
//let objB = ClassB(num: 10)
//    objB.prin()
//    objB.print()



class A {
    let b: B
    init() {
    b = B()
    b.a = self }
    
    func method(a: ()->())
    {
        print(a)
    }
    
    
    deinit {
    print("A deinit")
    } }
class B {
   weak var a: A? = nil
    deinit {
    print("B deinit")
    } }


var obj: A? = A()
obj?.method{}
    obj = nil

var go = []
go = [1,2,3,4,5,6]
for inde in go {
    print(inde)
}

for index in 0...4 {
    print(index+100)
}

var go2: [String]
go2 = ["1","2","4","3","5"]
for var obj in go2 {
    var i = ind
    obj = obj.substringFromIndex(Index(2))
    print(obj)
}















