//
//  FieldsButton.swift
//  Fields
//
//  Created by Don McBrien on 06/05/2021.
//

import SwiftUI

public struct FieldsButton<T: FieldsProtocol>: View {
   // Parameters
   @Binding var values: [T]
   var caption: String = ""
   var subcaption: String = ""
   var imageName: String
   var fieldValidator: FieldValidator<T>?
   var sheetValidator: SheetValidator<T>?
   
   // Environment
   @EnvironmentObject var environment: FieldsEnvironment
   
   // Local State
   @State private var isPresented: Bool = false

   // all public structs need a public init - pity
   public init(values: Binding<[T]>, caption: String = "", subcaption: String = "", imageName: String = "list.bullet.rectangle", fieldValidator: FieldValidator<T>? = nil, sheetValidator: SheetValidator<T>? = nil) {
      self._values = values
      self.caption = caption
      self.subcaption = subcaption
      self.imageName = imageName
      self.fieldValidator = fieldValidator
      self.sheetValidator = sheetValidator
   }
   
   public var body: some View {
      VStack {
         HStack {
            FieldCaption(caption: caption,
                         subcaption: subcaption)
            Image(systemName: imageName)
               .resizable()
               .frame(width: 48, height:21)
               .multilineTextAlignment(.trailing)
               .padding(.vertical, 5)
               .padding(.horizontal, 10)
               .overlay(RoundedRectangle(cornerRadius: 4)
                           .stroke(lineWidth: 2))
               .padding(.all, 5)
         }
      }
      .onTapGesture { isPresented.toggle() }
      .sheet(isPresented: $isPresented,
             content: {
               FieldSheet(values: $values,
                          title: caption,
                          subtitle: subcaption,
                          fieldValidator: fieldValidator,
                          sheetValidator: sheetValidator,
                          isPresented: $isPresented)
                  // it seems Sheets need this modifier in iOS
                  //but not in macOS
                  .environmentObject(environment)
             })
   }
}

//MARK: - Previews
struct FieldsButton_Previews: PreviewProvider {
   static var previews: some View {
      FieldsButton(values: .constant([123.45,6.78,9.0]),
                   caption: "Double Array",
                   subcaption: "(sums to 1.0)",
                   imageName: "rectangle.split.3x3")
         .environmentObject(FieldsEnvironment.singleton)
   }
}


