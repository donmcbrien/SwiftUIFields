//
//  FieldsColumnStyle.swift (macOS only)
//  Fields
//
//  Created by Don McBrien on 06/05/2021.
//

import SwiftUI

struct FieldsColumnStyle: ViewModifier {
   @EnvironmentObject var environment: FieldsEnvironment
   
   func body(content: Content) -> some View {
      content
         .overlay(RoundedRectangle(cornerRadius: 8)
                     .stroke(lineWidth: 2)
                     .shadow(color: Color.gray.opacity(0.8), radius: 2, x: 1, y: 2))
   }
}

extension View {
   public func fieldsColumnStyle() -> some View {
      ModifiedContent(
         content: self,
         modifier: FieldsColumnStyle()
      )
   }
}
