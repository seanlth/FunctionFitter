//
//  MFraction.swift
//  FunctionFitter
//
//  Created by Seán Hargadon on 27/01/2015.
//  Copyright (c) 2015 Seán Hargadon. All rights reserved.
//

import Foundation


//[0, 255]
//[255, 255]
//[255, 224]


//01000
//10010


//[255, 255]
//[255, 255]
//[1  , 255]


//2 0

//255


//11
//11

//256
//256

//3210
//1000
//1000
//000

//1

class StringNum {
    
    
    
}

class Num {
    private var Number: [UInt8]
    
    private func append(i: Int, n: UInt8) {
        if (i >= Number.count) {
            self.Number.append(n)
        }
        else {
            self.Number[i] = n
        }
    }
    
    init(number: UInt8) {
        if (number >= 100) {
            self.Number = [99]
        }
        else {
            self.Number = [number]
        }
    }
    
    func printNum()
    {
        var stringNum = ""
        
        for var i = self.Number.count-1; i >= 0; i-- {
            if (i == self.Number.count-1) {
                stringNum += String(self.Number[i])
            }
            else {
                if (self.Number[i] > 10) {
                    stringNum += String(self.Number[i])
                }
                else {
                    stringNum += "0" + String(self.Number[i])
                }
            }
        }
        print(stringNum)
    }
    
    subscript(i :Int) -> UInt8 {
        if (self.Number.count <= i) {
            return 0
        }
        return self.Number[i]
    }
}


func + (l: Num, r: Num) -> Num {
    var result: Num = Num(number: 0)
    
    var length = (l.Number.count > r.Number.count ? l.Number.count : r.Number.count)

    var remainder: UInt8 = 0
    var carry: UInt8 = 0
    
    
    for var i = 0; i < length; i++ {
        
        
        var max: UInt8 = (l[i] > r[i] ? l[i] : r[i])
        var min: UInt8 = (l[i] > r[i] ? r[i] : l[i])

        if 100 - l[i] <= r[i] {
            
            var remainder = min - (100 - max);
            
            result.append(i, n: remainder)
            carry = 1
        }
        else {
           
            result.append(i, n: l[i] + r[i] + carry)
            
            carry = 0
        }
    }
    
    if carry == 1 {
        result.Number.append(carry)
    }

    return result
}

//1, 0
//0, 1
//0, 99

//1, 1
//2, 1

func - (l: Num, r: Num) -> Num {
    
    var result: Num = Num(number: 0)
    
    var length = (l.Number.count > r.Number.count ? l.Number.count : r.Number.count)
    
    var remainder: UInt8 = 0
    var carry: UInt8 = 0
    
    
    for var i = 0; i < length; i++ {
        
        
        var max: UInt8 = (l[i] > r[i] ? l[i] : r[i])
        var min: UInt8 = (l[i] > r[i] ? r[i] : l[i])
        
        if 100 - l[i] <= r[i] {
            
            var remainder = min - (100 - max);
            
            result.append(i, n: remainder)
            carry = 1
        }
        else {
            
            result.append(i, n: l[i] - r[i] + carry)
            
            carry = 0
        }
    }
    
    if carry == 1 {
        result.Number.append(carry)
    }
    
    return result
}


func * (l: Num, r: Num) -> Num {
    var result: Num = Num(number: 0)
    
    
    //for var i = 0; i < nu)
    
    
//    var length = (l.Number.count > r.Number.count ? l.Number.count : r.Number.count)
//    
//    var remainder: UInt8 = 0
//    var carry: UInt8 = 0
//    
//    
//    for var i = 0; i < length; i++ {
//        
//        
//        var max: UInt8 = (l[i] > r[i] ? l[i] : r[i])
//        var min: UInt8 = (l[i] > r[i] ? r[i] : l[i])
//        
//        if UInt8(ceil(100.0 / Double(l[i]))) <= r[i] {
//            
//            var remainder = min - (100 - max);
//            
//            result.append(i, n: remainder)
//            carry = 1
//        }
//        else {
//            
//            result.append(i, n: l[i] + r[i])
//            
//            carry = 0
//        }
//    }
//    
//    if carry == 1 {
//        result.Number.append(carry)
//    }
    
    return result
}


func < (l: Num, r: Num) -> Bool {
    var result: Num = Num(number: 0)
    
    
    return false;
}




class MFraction {
    private var numerator: Int
    private var denominator: Int
    
    private func reduce() {
        if ( self.numerator != 0 ) {
            var R1 = numerator;
            var R2 = denominator;
            
            if (R2 > R1) {
                R1 = denominator;
                R2 = numerator;
            }
            var r = R1%R2;
            var d = R1/R2;
            R1 = R2;
            R2 = r;
            while (r != 0) {
                r = R1%R2;
                d = R1/R2;
                R1 = R2;
                R2 = r;
            }
            numerator /= R1;
            denominator /= R1;
        }
        else {
            self.denominator = 1;
        }
    }
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    internal func expressAsDecimal() -> Double {
        
        return ( Double(self.numerator) / Double(self.denominator) )
    }
    
    internal func printFraction() {

        if (self.denominator == 1) {
            print("\(self.denominator)")
        }
        else {
            let s: String = "asdasd \(5)"
            
            print("\(self.numerator) / \(self.denominator)")
        }
    }
}

