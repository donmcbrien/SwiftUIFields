//
//  FieldsProtocol.swift
//  Fields
//
//  Created by Don McBrien on 13/04/2021.
//

import Foundation
import SwiftUI

// 'CustomDatumProtocol' and extensions to 'struct's which should conform with it
// The protocol requires that instances of conforming structs can be represented
// by a 'String' and should have a failable initialiser which converts a 'String'
// to an instance of the struct. (Note that they are usually very easy to implement)

public protocol FieldsProtocol: Equatable {
   init?(_ string: String) // already conformed to by most types
   func stringified() -> String
}

extension Double: FieldsProtocol {
   public func stringified() -> String {
      // basic format and strip away tailing "0"'s
      var str = String(format: "%f", self)
      while str.last == "0" { str.removeLast() }
      if str.last == "." { str += "0" }
      return str
   }
}

extension CGFloat: FieldsProtocol {
   public init?(_ string: String) {
      if let v = Double(string) {
         self = CGFloat(v)
      }
      else { return nil }
   }
   
   public func stringified() -> String {
      // basic format and strip away tailing "0"'s
      var str = String(format: "%f", self)
      while str.last == "0" { str.removeLast() }
      if str.last == "." { str += "0" }
      return str
   }
}

extension Int: FieldsProtocol {
   public func stringified() -> String {
      String(format: "%d", self)
   }
}

extension ClosedRange: FieldsProtocol where Bound == Int {
   public init?(_ string: String) {
      let parts = string.components(separatedBy: "...").filter { !$0.isEmpty }
      if parts.count != 2 { return nil }
      if let from = Int(parts[0]) {
         if let to = Int(parts[1]) {
            self = from ... to
         } else { return nil }
      } else { return nil }
    }
   
   public func stringified() -> String {
      "\(self)"
   }
}

extension Range: FieldsProtocol where Bound == Int {
   public init?(_ string: String) {
      let parts = string.components(separatedBy: "..<").filter { !$0.isEmpty }
      if parts.count != 2 { return nil }
      if let from = Int(parts[0]) {
         if let to = Int(parts[1]) {
            self = from ..< to
         } else { return nil }
      } else { return nil }
    }
   
   public func stringified() -> String {
      "\(self)"
   }
}

extension String: FieldsProtocol {
   public func stringified() -> String { self }
}

