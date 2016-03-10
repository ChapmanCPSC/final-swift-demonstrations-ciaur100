//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
Optionals
*/

// Optional class
var testOptional: Optional = Optional()

// Optional Strings can be nil
let nilString:String? = nil


// Functions can return optional
let stringNumber = "1235"
if let intFromString = Int(stringNumber){
    print("hurray it worked")
}else{
    print("String to int conversion failed")
}

// Force unwrap
let failingStringNumber = "abc123"
//let breaksEverything = Int(failingStringNumber)!

//Optional Chaining
Int("123")?.advancedBy(5)

// Comparison
if Int("123") == Int("123"){
    print("Comparing 123 to 123")
}else if Int("12b") == nil{
    print("Could not convert")
}else if Int("123") == Int("12b"){
    print("Breaks, because one of them returns nil")
}

/*
Object Types
*/

// Protocol
protocol FireBreather{
    func breatheFire()
}

// Enum
enum DragonError:ErrorType{
    case EmptyTummy
    case OutOfFire
}

// Class
class Dragon: FireBreather{
    
    // Properties
    var name: String
    var wingspan: Int
    var canBreatheFire: Bool
    var isAlive: Bool = true
    var kittensEaten: [String] = [String]()
    
    
    // Static property
    static var areExtinct: Bool = false
    private static var currentNames: [String] = [String]()
    
    required init?(name: String, wingspan: Int, canBreatheFire: Bool){
        self.name = name
        self.wingspan = wingspan
        self.canBreatheFire = canBreatheFire
        
        if Dragon.currentNames.contains(name){
            print("Cannot have 2 dragons with the same name. It's the rules.")
            return nil
        }else{
            Dragon.currentNames.append(name)
        }
    }
    
    // Subscript
    func eatKitten(kittenName: String){
        kittensEaten.append(kittenName)
    }
    
    // Error
    func regurgitateLastKitten() throws{
        if kittensEaten.isEmpty{
            throw DragonError.EmptyTummy
        }else{
            print("Burrrrp \(kittensEaten.popLast()!)")
        }
    }
    
    // While loop
    func barfAllKittens(){
        while !kittensEaten.isEmpty{
            print(kittensEaten.popLast())
        }
    }
    
    // Class method
    class func makeExtinct(){
        areExtinct = true
    }
    
    class func killDragon(dragon: Dragon){
        if let index = currentNames.indexOf(dragon.name){
            currentNames.removeAtIndex(index)
            dragon.isAlive = false
        }else{
            print("The dragon is already dead")
        }
    }
    
    subscript(var dragonIndex: Int) -> String?{
        return kittensEaten[dragonIndex]
    }
    
    func breatheFire() {
        if canBreatheFire{
            print("Kebab time")
        }else{
            print("cough")
        }
    }
}

if var d1 = Dragon(name: "fred", wingspan: 5, canBreatheFire: true){
    // Fails because name already exists and failiable initializer
    let d2 = Dragon(name: "fred", wingspan: 3, canBreatheFire: true)
    let d3 = Dragon(name: "hank", wingspan: 10, canBreatheFire: false)
    Dragon.killDragon(d1)
    
    // Works because we killed the first fred
    let d4 = Dragon(name: "fred", wingspan: 3, canBreatheFire: true)
}

final class FatDragon: Dragon{
    required init?(name: String, wingspan: Int, canBreatheFire: Bool) {
        super.init(name: name, wingspan: wingspan, canBreatheFire: canBreatheFire)
    }
    
    deinit{
        // This is where I would release memory and stuff
        Dragon.killDragon(self)
    }

    // For loop
    func eatMultipleKittens(kittens:[String]){
        for kitten in kittens{
            eatKitten(kitten)
        }
        print("burp")
    }
}

// Extension
extension Dragon{
    func rainHellfire(){
        print("Raining hellfire now")
    }
}



// Subscript
let d5 = Dragon(name: "spiderman", wingspan: 0, canBreatheFire: false)!
d5.eatKitten("fuzzy")
let firstKitten = d5[0]

// Casting
if let fatD5 = d5 as? FatDragon{
    print("hurray fatties")
    fatD5.eatMultipleKittens(["fuzzy","wuzzy","lion"])
    try? fatD5.regurgitateLastKitten()
    try! fatD5.regurgitateLastKitten()
    
    
}

try? d5.regurgitateLastKitten()
// Breaks
//try! d5.regurgitateLastKitten()
do{
    try d5.regurgitateLastKitten()
}catch DragonError.EmptyTummy{
    print("Empty tummy can't barf")
}catch let error{
    print("another error that could have been thrown from another function within the do block")
}

/*
Enum
*/

enum WritingUtensil:String{
    case Pencil = "pencil"
    case Pen = "pen"
    case Quill = "feather"
    case BloodyFinger = "emo"
}

let fails = WritingUtensil(rawValue: "wat")
let wins = WritingUtensil(rawValue: "pen")
let switched = WritingUtensil.BloodyFinger

switch switched{
case .Pencil:
    print("lead breaks")
case .Pen:
    fallthrough
default:
    break
}


/*
Struct
*/

struct Constants{
    static var brandColor: UIColor = UIColor.blackColor()
    var currentDeviceTheme: UIColor = brandColor
    
    static func changeBrandColorTo(newColor: UIColor){
        brandColor = newColor
    }
    
    mutating func changeTheme(newColor: UIColor){
        currentDeviceTheme = newColor
    }
}

var c = Constants()
c.currentDeviceTheme
c.changeTheme(UIColor.blueColor())
c.currentDeviceTheme


/*
Collection Types
*/

var dragonArray = [Dragon]()
dragonArray.append(Dragon(name: "bill", wingspan: 2, canBreatheFire: true)!)

for dragon in dragonArray{
    dragon.breatheFire()
}

for (index, dragon) in dragonArray.enumerate(){
    print("Dragon number \(index+1), breathe fire!")
    dragon.breatheFire()
}

// Dictionary
var dragonDict = [String:Dragon]()
dragonDict["bestDragon"] = d5
dragonDict["fattestDragon"] = d5

// Ternary Thingy
let bestIsFattest = dragonDict["bestDragon"]?.name == dragonDict["fattestDragon"]?.name
let statement = "The dragon leaderboard is \(bestIsFattest ? "looking pretty lonely" : "diverse!")"