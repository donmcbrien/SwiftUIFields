//
//  CustomSectionStyle.swift
//  Fields
//
//  Created by Don McBrien on 09/05/2021.
//

import SwiftUI

//MARK: - Custom Modifiers
struct FieldsSectionStyle: ViewModifier {
   @EnvironmentObject var environment: FieldsEnvironment
   var foregroundColor: Color?
   
   func body(content: Content) -> some View {
      content
         .padding(.vertical)
         .frame(maxWidth: .infinity)
         .background(Color.yellow)
         .font(.title2)
         .foregroundColor(.blue)
   }
}

extension View {
   public func fieldsSectionStyle() -> some View {
      ModifiedContent(
         content: self,
         modifier: FieldsSectionStyle()
      )
   }
}
