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


class Num {
    var Number: [UInt8]
    
    init(number: UInt8) {
        self.Number = [number];
    }
    
    func printNum()
    {
        
    }
}


func + (l: Num, r: Num) -> Num {
    var result: Num = Num(number: 0);
    
    var length = (l.Number.count > r.Number.count ? l.Number.count : r.Number.count)
    
    var remainder: UInt8 = 0
    var carry: UInt8 = 0;
    
    for var i = 0; i < length; i++ {

        if 255 - l.Number[i] < r.Number[i] {
            result.Number[i] = l.Number[i] &+ r.Number[i] + carry
            carry = 1;
        }
        else {
            result.Number[i] = l.Number[i] + r.Number[i]
            carry = 0;
        }
    }
    
    if carry == 1 {
        result.Number.append(carry);
    }

    return r
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

