
import UIKit

// Press ⌘1 (Or use View -> Navigators menu) to open Project Navigation to choose the file.


struct Point2D {
    var x: Double
    var y: Double
}

var point1 = Point2D(x: 2, y: 3)
var point2 = Point2D(x: 3, y: 6)

func pointToPoint(p1: Point2D, p2: Point2D)->Point2D {
    let x  = p1.x + p2.x
    let y = p1.y + p2.y
    return Point2D(x: x, y: y)
}

var point3 = pointToPoint(point1, p2: point2)

infix operator && {
    associativity left precedence 180
}

func &&(p1:Point2D, p2: Point2D)->Point2D {
    let x = p1.x + p2.x
    let y = p1.y + p2.y
    return Point2D(x: x, y: y)
}

var point4 = point1 && point2
print(point4)



typealias Action = ()->Void
typealias AsyncTask = (Action)->Void

func &&(lhs: AsyncTask, rhs: Action) -> AsyncTask {
    return { (action)->Void in
        lhs{rhs();action()}
    }
}


func updateStautus(str:String, progress:Float=0, reload: Bool=false) -> Void {
    print(str)
}


func updateStautus2(str:String, progress:Float=0, reload: (String)->String) ->(String)->String {
    print(str)
    reload("0000")
    return {str->String in
        print("dsafd")
        return str
    }
}

updateStautus("正在更新...");

let reload:(String)->String = {str -> String in
    print(str)
    return  ""
}

let action = updateStautus2("9999", progress: 0,reload: reload)

action("rewtr")




struct Sentence {
    let sentence: String
    init(_ sentence: String) {
        self.sentence = sentence
    }
}

extension Sentence: Equatable, Comparable {
}

func ==(lhs:Sentence, rhs: Sentence)->Bool {
    return lhs.sentence == rhs.sentence
}
func !=(lhs:Sentence, rhs: Sentence)->Bool {
    return lhs.sentence != rhs.sentence
}


func >(lhs:Sentence, rhs: Sentence)->Bool {
    return lhs.sentence > rhs.sentence
}
func <(lhs:Sentence, rhs: Sentence)->Bool {
    return lhs.sentence < rhs.sentence
}
func >=(lhs:Sentence, rhs: Sentence)->Bool {
    return lhs.sentence >= rhs.sentence
}
func <=(lhs:Sentence, rhs: Sentence)->Bool {
    return lhs.sentence <= rhs.sentence
}

let sen1 = Sentence("hello world")
let sen2 = Sentence("hello swift")


func compare() {
    if sen1 != sen2 {
        print("yes")
    }
    else {
        print("no")
    }
}

compare()


protocol printfable {
    func printString()
}


extension printfable {
    func printString(){
        print("printfable")
    }
    
    func printSelf() {
        print("\(self)")
    }
}

extension Sentence: printfable {
   
}

let sen = Sentence("prin")
sen.printString()
sen.printSelf()










