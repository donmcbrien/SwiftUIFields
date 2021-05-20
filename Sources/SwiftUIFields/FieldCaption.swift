//
//  FieldCaption.swift
//  Fields
//
//  Created by Don McBrien on 06/05/2021.
//

import SwiftUI

struct FieldCaption: View {
   // Parameters
   var caption: String
   var subcaption: String = ""
   
   // Environment
   @EnvironmentObject var environment: FieldsEnvironment
   
   var body: some View {
      VStack(alignment: .trailing) {
         Text(caption).font(.title3)
         if subcaption.count > 0 { Text(subcaption).font(.caption) }
      }
      .lineLimit(1)
      .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
   }
}

struct FieldCaption_Previews: PreviewProvider {
   static var previews: some View {
      FieldCaption(caption: "Caption",
                  subcaption: "this is a sub-caption")
         .environmentObject(FieldsEnvironment.singleton)
   }
}
