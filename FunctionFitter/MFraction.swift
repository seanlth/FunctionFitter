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

class Num : Printable {
    private var neg: Bool
    private var Number: [UInt16]
    
    private func append(i: Int, n: UInt16) {
        if (i >= Number.count) {
            self.Number.append(n)
        }
        else {
            self.Number[i] = n
        }
    }
    
    init(number: UInt16) {
        neg = false;
        if (number >= 100) {
            self.Number = [99]
        }
        else {
            self.Number = [number]
        }
    }
    
    init(number: [UInt16]) {
        neg = false;
        var err = false
        
        var temp: [UInt16] = []
        
        for var i = number.count-1; i >= 0; i-- {
            temp.append( number[i] )
            if (i >= 100) {
                err = true
                break
            }
        }
        
        if (err) {
            self.Number = [0]
        }
        else {
            self.Number = temp
        }
    }
    
    var description: String {
        var stringNum = ""

        if (neg) {
            stringNum = "-"
        }
        
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
        return stringNum;
    }
    
//    private subscript(i :Int) -> UInt16 {
//        if (self.Number.count <= i) {
//            return 0
//        }
//        return self.Number[i]
//    }
    
    private subscript(i :Int) -> UInt16 {
      
        get {
            if i >= self.Number.count {
                for var j = 0; j < (i - self.Number.count) + 1; j++ {
                    self.Number.append(0)
                }
            }
            return self.Number[i]
        }
        set(value) {
            if i >= self.Number.count {
                for var j = 0; j < i - self.Number.count; j++ {
                    self.Number.append(0)
                }
            }
            self.Number[i] = value
        }
    }
}


func + (l: Num, r: Num) -> Num {
    var result: Num = Num(number: 0)
    
    var length = (l.Number.count > r.Number.count ? l.Number.count : r.Number.count)

    var remainder: UInt16 = 0
    var carry: UInt16 = 0
    
    
    for var i = 0; i < length; i++ {
        
        
        var max = (l[i] > r[i] ? l[i] : r[i])
        var min = (l[i] > r[i] ? r[i] : l[i])

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

//0, 99, 200
//0, 0, 101
//_________
//0, 0,  -1


func - (l: Num, r: Num) -> Num {
    
    var result: Num = Num(number: 0)
    
    var length = (l.Number.count > r.Number.count ? l.Number.count : r.Number.count)
    
    var remainder: UInt16 = 0
    var carry: UInt16 = 0
    
    
    for var i = 0; i < length; i++ {
        
        var max: UInt16 = (l[i] > r[i] ? l[i] : r[i])
        var min: UInt16 = (l[i] > r[i] ? r[i] : l[i])
        
        if carry == 1 {
            if l[i] == 0 {
                l.Number[i] = 100;
                carry = 1;
            }
            else {
                carry = 0;
            }
            l.Number[i]--;
        }
        
        if l[i] < r[i] {
            var remainder = (100+min) - max;
            result.append(i, n: remainder)
            carry = 1
        }
        else {
            var temp =  l[i] - r[i]
            if (temp != 0 || i != length - 1) {
                result.append(i, n: temp)
            }
        }
    }
    
    if carry == 1 {
        result.neg = true;
    }
    
    return result
}


func * (l: Num, r: Num) -> Num {
    var result: Num = Num(number: 0)
    
    var length = (l.Number.count > r.Number.count ? l.Number.count : r.Number.count)
    
    var remainder: UInt16 = 0
    var carry: UInt16 = 0
    
    for var i = 0; i < r.Number.count; i++ {
        
        for var j = 0; j < l.Number.count; j++ {
            
            var resultIndex = i > j ? i : j
            
            var lV = l[j] == 0 ? 1 : l[j]
            var rV = r[i] == 0 ? 1 : r[i]
            
            var max: UInt16 = (lV > rV ? lV : rV)
            var min: UInt16 = (lV > rV ? rV : lV)
            
            var temp = lV * rV
            
            println(lV)
            println(rV)
            println("___\n")

            
            if temp >= 100 {
                
                remainder = temp % 100;
                
                //result.append(i, n: remainder + carry)
                
                
                
                result[resultIndex] += remainder + carry
                
                carry = temp / 100
                
            }
            else if temp + carry >= 100 {
                
                remainder = (temp + carry) % 100
                
                //result.append(i, n: remainder)
                
                result[resultIndex] += remainder
                
                carry = (temp + carry) / 100
            }
            else {
                
                result[resultIndex] += temp + carry

                //result.append(i, n: temp + carry)
                
                carry = 0
            }

        }
    }
    
    if carry != 0 {
        result.Number.append(carry)
    }
    
    return result
}


func ^ (var l: Num, r: Int) {
    
    for var i = 0; i < r; i++ {
        l = l * l
    }
}

func == (l: Num, r: Num) -> Bool {
    
    var temp = l - r
    
    for n in temp.Number {
        if (n != 0) {
            return false
        }
    }
    
    return true
}

func < (l: Num, r: Num) -> Bool {
    return (l - r).neg
}

func > (l: Num, r: Num) -> Bool {
    return !(l - r).neg
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
            print("\(self.numerator) / \(self.denominator)")
        }
    }
}

