//
//  CustomFieldStyle.swift
//  Fields
//
//  Created by Don McBrien on 13/04/2021.
//

import Foundation
import SwiftUI

struct FieldsFieldStyle: ViewModifier {
   @EnvironmentObject var environment: FieldsEnvironment
   var foregroundColor: Color?
   
   func body(content: Content) -> some View {
      content
         .multilineTextAlignment(.trailing)
         .foregroundColor(foregroundColor)
         .padding(.all, 5)
         .overlay(RoundedRectangle(cornerRadius: 4)
                     .stroke(lineWidth: 2))
         .padding(.all, 5)
         .frame(width: environment.fieldWidth)
   }
}

extension View {
   public func fieldsFieldStyle(foregroundColor: Color? = .black) -> some View {
      ModifiedContent(
         content: self,
         modifier: FieldsFieldStyle(foregroundColor: foregroundColor)
      )
   }
}
