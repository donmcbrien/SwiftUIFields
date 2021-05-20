//
//  FieldsEnvironment.swift
//  Fields
//
//  Created by Don McBrien on 18/04/2021.
//

import Foundation
import SwiftUI

public class FieldsEnvironment: ObservableObject, CustomStringConvertible {
   // Singleton
   static public let singleton = FieldsEnvironment()
   private init() {}
   
   // reports back to caller that the custom field is in a valid state
   @Published public var commit = true
   @Published public var marginWidth: CGFloat = 0   // space between column on macOS, nil on phone

   @Published public var columnWidth: CGFloat  = 500  // iPhone width equivalent
   @Published public var macWidth: CGFloat  = 400  // mac starting width
   @Published public var macHeight: CGFloat  = 300  // mac starting height
   public var size: CGSize = CGSize.zero
   
   public var rowWidth: CGFloat { columnWidth - (2 * spacerWidth) } // used part of column
   public var spacerWidth: CGFloat = 20  // unused part of column
   public var fieldWidth: CGFloat { min(max((rowWidth - spacerWidth) * 0.3, 100), 120) }
   public var captionWidth: CGFloat { rowWidth - spacerWidth - fieldWidth }

   public var buttonImageWidth: CGFloat = 50
   public var buttonCaptionWidth: CGFloat { (rowWidth - buttonImageWidth - (2 * spacerWidth)) }

   public var description: String {
      "marginWidth: \(marginWidth)\n" + "columnWidth: \(columnWidth)\n" + "rowWidth: \(rowWidth)\n" + "spacerWidth: \(spacerWidth)\n" + "fieldWidth: \(fieldWidth)\n" + "captionWidth: \(captionWidth)\n" + "buttonImageWidth: \(buttonImageWidth)\n" + "buttonCaptionWidth: \(buttonCaptionWidth)\n"

   }
}
