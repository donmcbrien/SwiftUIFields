//
//  FieldsValidators.swift
//  Fields
//
//  Created by Don McBrien on 02/05/2021.
//

import Foundation

public struct FieldValidator<T: FieldsProtocol> {
   let validator: (T) -> Bool
   let errorMessage: String
   
   public init(_ validator: @escaping (T) -> Bool, _ errorMessage: String) {
      self.validator = validator
      self.errorMessage = errorMessage
   }
}

public struct SheetValidator<T: FieldsProtocol> {
   let validator: ([T]) -> Bool
   let errorMessage: String

   public init(_ validator: @escaping ([T]) -> Bool, _ errorMessage: String) {
      self.validator = validator
      self.errorMessage = errorMessage
   }
}
