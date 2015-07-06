//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Origin {
    var originX: CGFloat?
    var originY: CGFloat?
}

struct Size {
    var width: CGFloat?
    var height: CGFloat?
}

struct SomeStruct {
    
    var x: CGFloat? = 0
   
    var y: CGFloat? = 0
    
    var width: CGFloat? = 0
    
    var height: CGFloat? = 0
    
    var origin: Origin?
    
    var size: Size?
    
    var center: Origin?
    
    init(){}
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)
    {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    init(origin: CGPoint,size: CGSize)
    {
        self.origin?.originX = origin.x
        self.origin?.originY = origin.y
        self.size?.height = size.height
        self.size?.width = size.width
    }
    
    init(center: CGPoint, size: CGSize)
    {
        let x = center.x - size.width/2
        let y = center.y - size.height/2
        self.init(x: x, y: y, width: size.width,height: size.height)
    }
    
    
    
    
}

let someStruct = SomeStruct(x: 0, y: 0, width: 320, height: 568)

someStruct.height

class ClassA {
    var name: String  =
    {
       return "pang"
    }()
    var age: CGFloat = 10
    init(name: String, age: CGFloat)
    {
        self.age = age
        self.name = name
    }
    
    convenience init (name: String)
    {
        self.init(name: name,age: 19)
    }
    
}

class ClassB: ClassA {
    
    
    
    var firstName: String
    var myAge: CGFloat
    
    override init(name: String, age: CGFloat) {
        
        self.firstName = name
        self.myAge = age
        
        super.init(name: name, age: age)
        self.name = "hhhh"
    }
    
    func prints()
    {
        print("firstname:\(firstName),myAge:\(myAge)")
    }
    
    
    convenience init (firstname:String)
    {
        self.init(name:firstname,age:10)
    }
    
}



var b = ClassB(name: "pangfuli", age: 30)
b.prints()

b.name


var b1 = ClassB(name: "na")
b1.age
b1.firstName
b1.name


protocol TargetAction
{
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>: TargetAction
{
    weak var target: T?
    var action: (T) -> () -> ()

    func performAction() {
        
        if let t = target
        {
          action(t)()
            print("dddddddddd")
        }
         print("dddddddddd")
    }
    
}

enum ControlEvent
{
    case TouchUpInside
    case ValueChanged
}

class Control {
    
    var actions = [ControlEvent : TargetAction]()
    
    func setTarget<T: AnyObject>(target: T, action: (T)->()->(), controlEvent:ControlEvent)
    {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlevent: ControlEvent)
    {
        actions[controlevent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent)
    {
        actions[controlEvent]?.performAction()
    }
    
    
}

class MyClass: Control {
    
}

func afunc(any: AnyObject)()->()
{
    print("hahhaha")
}

let myClass = MyClass()
let target = TargetActionWrapper(target: "ss", action: afunc)
let event = ControlEvent.TouchUpInside
myClass.actions = [event:target]
myClass.performActionForControlEvent(ControlEvent.TouchUpInside)
myClass.setTarget("a3434", action: afunc, controlEvent: ControlEvent.TouchUpInside)

func hahad()
{
    
}









