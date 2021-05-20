//
//  FieldsButtonStyle.swift
//  Fields
//
//  Created by Don McBrien on 18/04/2021.
//

import Foundation
import SwiftUI

struct FieldsButtonStyle: ViewModifier {
   @EnvironmentObject var environment: FieldsEnvironment
   
   func body(content: Content) -> some View {
      content
         .multilineTextAlignment(.trailing)
         .background(Color.secondary.opacity(0.2))
         .padding(.all, 8)
         .overlay(RoundedRectangle(cornerRadius: 4)
                     .stroke(lineWidth: 2)
                     .shadow(color: Color.primary.opacity(0.8), radius: 2, x: 1, y: 2))
         .padding(.all, 5)
   }
}

extension View {
   public func fieldsButtonStyle(width: CGFloat? = 120) -> some View {
    ModifiedContent(
      content: self,
      modifier: FieldsButtonStyle()
    )
  }
}
