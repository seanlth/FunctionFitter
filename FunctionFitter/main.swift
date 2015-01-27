//
//  main.swift
//  FunctionFitter
//
//  Created by Seán Hargadon on 27/01/2015.
//  Copyright (c) 2015 Seán Hargadon. All rights reserved.
//

import Foundation

var f = MFraction(numerator: 1, denominator: 2)

f.printFraction();


var n1 = Num(number: 255)
var n2 = Num(number: 255)
var r = n1

for i in (0...1000) {
    r = r + r
}