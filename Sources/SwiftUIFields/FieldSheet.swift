//
//  FieldSheet.swift
//  Fields
//
//  Created by Don McBrien on 17/04/2021.
//

import SwiftUI

struct FieldSheet<T: FieldsProtocol>: View {
   // Parameters
   @Binding var values: [T]
   var title: String = ""
   var subtitle: String
   var fieldValidator: FieldValidator<T>?
   var sheetValidator: SheetValidator<T>?
   @Binding var isPresented: Bool

   // Environment
   @EnvironmentObject var environment: FieldsEnvironment

   // Local State
   @State var isInvalid: Bool = false
   
   var body: some View {
      VStack {
         HStack {
            Text(title).font(.largeTitle)
            Button(action: { validateCollection() },
                   label: { Image(systemName: "return") })
               .disabled(!environment.commit)
               .padding(5)
               .overlay(RoundedRectangle(cornerRadius: 4)
                           .stroke(Color.gray, lineWidth: 2))
         }
         Text(subtitle).font(.subheadline)
         
         Divider()

         sheetBody()
      }
   }
   
   private func sheetBody() -> some View {
      return ScrollView {
         LazyVStack {
            ForEach(values.indices, id: \.self) {
               idx in
               Field(value: $values[idx],
                     caption: "[\(idx)]:",
                     fieldValidator: fieldValidator)
                  .onTapGesture {
                     if let validator = sheetValidator?.validator {
                        isInvalid = !validator(values)
                      }
                  }
            }
            if isInvalid {
               Text( "Collection does not meet validation condition")
                  .foregroundColor(.red)
            }
         }
      }
   }

   private func validateCollection() {
      if let validator = sheetValidator?.validator {
         isInvalid = !validator(values)
         if !isInvalid { isPresented = false }
      } else {
         isPresented = true
      }
   }
}

struct FieldSheet_Previews: PreviewProvider {
   static var previews: some View {
      FieldSheet(values: .constant([1,2,3,4]),
                 title: "Double Array",
                 subtitle: "",
                 isPresented: .constant(false))
         .environmentObject(FieldsEnvironment.singleton)
   }
}

