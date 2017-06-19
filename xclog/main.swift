//
//  main.swift
//  xclog
//
//  Copyright (c) 2017 Hiroaki ENDOH
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation
import Cocoa

var arguments = CommandLine.arguments.suffix(from: 1)
if (arguments.contains("-v") || arguments.contains("--version")) {
    let exePath: URL = URL.init(fileURLWithPath: CommandLine.arguments[0])
    let productName: String = exePath.lastPathComponent
    print("\(productName) version 0.0.1")
    exit(EXIT_SUCCESS)
}

let standardInput = FileHandle.standardInput
let standardOutput = FileHandle.standardOutput
let parser: Parser = Parser()

while let line:String = readLine() {
    var formattedText = parser.parse(text: line)
    if formattedText.isEmpty {
        continue
    } else {
        formattedText = formattedText.appending("\n")
    }
    let dataout: Data? = formattedText.data(using: String.Encoding.utf8)
    if let dout = dataout {
        standardOutput.write(dout)
    }
}
