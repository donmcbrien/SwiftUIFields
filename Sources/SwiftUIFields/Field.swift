//
//  Field.swift
//  Fields
//
//  Created by Don McBrien on 22/04/2021.
//

import SwiftUI

public struct Field<T: FieldsProtocol>: View {
   // Parameters
   @Binding var value: T { didSet { self.string = value.stringified() } }
   var caption: String = ""
   var subcaption: String = ""
   var fieldValidator: FieldValidator<T>?

   // Environment
   @EnvironmentObject var environment: FieldsEnvironment
   
   // Local State
   @State private var string: String = ""
   @State private var editingInProgress = false
   @State private var store = ""
   @State private var foregroundColor: Color? = .black
   @State private var invalid: Bool = false
   private var showCaption: Bool { caption != "" || subcaption != "" }

   // all public structs need a public init - pity
   public init(value: Binding<T>, caption: String = "", subcaption: String = "", fieldValidator: FieldValidator<T>? = nil) {
      self._value = value
      self.caption = caption
      self.subcaption = subcaption
      self.fieldValidator = fieldValidator
   }
   
   public var body: some View {
      VStack {
         HStack {
            if showCaption {
               FieldCaption(caption: caption,
                            subcaption: subcaption)
            }
            FieldValue(value: $value,
                       fieldValidator: fieldValidator,
                       invalid: $invalid)
         }
         if invalid { showInvalidMessage() }
      }
   }
   
   private func showInvalidMessage() -> some View {
      Text(fieldValidator!.errorMessage)
         .frame(width: environment.rowWidth)
         .foregroundColor(.red)
         .font(.subheadline)
   }
}

//MARK: - Previews
struct CustomFieldRow_Previews: PreviewProvider {
   static var previews: some View {
      VStack {
         VStack(alignment: .trailing) {
            Field(value: .constant(-123.45),
                  caption: "Double:",
                  subcaption: "no constraint",
                  fieldValidator: FieldValidator({ v in v >= 0 },
                                                 "Must be positive"))
            Field(value: .constant(123.45),
                  caption: "Double:")
         }
         Field(value: .constant(123.45))
      }
      .environmentObject(FieldsEnvironment.singleton)
   }
}

