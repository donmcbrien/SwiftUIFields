//
//  CustomField.swift
//  Fields
//
//  Created by Don McBrien on 30/04/2021.
//

import SwiftUI

struct FieldValue<T: FieldsProtocol>: View {
   // Packages a value to be edited, providing a label and a customised field with
   // some styling modifiers
   // Receives a binding ('value') to a custom type (T) and converts it to 'valueAsString'.
   // This is presented for editing in a standard SwiftUI TextField. Any kind of
   // string editing is permitted and is committed either by pressing <return> or
   // switching focus away from the TextField.
      // In the latter case, any editing is lost,'valueAsString' restored from
      // 'revertAsString' and 'value' remains unchanged.
      // In the former case, 'valueAsString' is converted to type T (if possible)
      // and 'value' is updated.
      // If conversion to T is not possible, the effect is the same as losing focus.
   // The value loaded must, by definition, be valid.
   // Additionally, it is possible to provide an optional validation closure which
   // causes editing to revert to the 'revertAsString' if the condition encoded in
   // it is not met.
   // Type T must conform to 'CustomDatumProtocol' which requires that it can be cast
   // to a String and has a failable initialised from a String.

   // Parameters
   @Binding var value: T { didSet { self.valueAsString = value.stringified() } }
   var fieldValidator: FieldValidator<T>?
   @Binding var invalid: Bool

   // Environment
   @EnvironmentObject var environment: FieldsEnvironment
   
   // Local State (not private to admit updating in platform specific extensions)
   @State private var valueAsString: String = ""
   @State private var revertAsString = ""
   @State private var editingInProgress = false
   @State private var foregroundColor: Color? = .primary

   var body: some View {
      // iOS and macOS specific code in extension
      TextField("",
                text: $valueAsString,
                onEditingChanged: { isEditing in editingChanged(isEditing) },
                onCommit: { commitOrRevert() })
         .onAppear { loadAsString() }
         .onChange(of: value) { _ in loadAsString() }
         .fieldsFieldStyle(foregroundColor: foregroundColor)
   }

   private func loadAsString() {
      valueAsString = value.stringified()
      revertAsString = valueAsString
   }
   
   private func commitOrRevert() {
      // Only called during a commit
      // Cast to type T if possible and apply optional validator.
      foregroundColor = .primary
      environment.commit = true
      invalid = false
      guard let v = T(valueAsString) else {
         // if cast fails, revert
         valueAsString = revertAsString
         return
      }
      // if validator exists, run it
      if let optionalValidator = fieldValidator?.validator {
         // if validator fails, revert
         if !optionalValidator(v) {
            valueAsString = revertAsString
            invalid = true
            return
         }
      }
      // success: update
      value = v
      revertAsString = valueAsString
   }
}

#if os(iOS)
extension FieldValue {
   private func editingChanged(_ isEditing: Bool) {
      self.editingInProgress = isEditing
      if editingInProgress {
         // when focus is acquired, give visual clue and disable Button in caller.
         foregroundColor = .red
         environment.commit = false
         revertAsString = valueAsString
      } else {
         // usually after focus is lost via <enter> or switching to another TextField,
         // but sadly, not when lost by using a Button, hence the need for Editor to
         // disable the button in the calling struct (such as CustomRow).
         foregroundColor = .black
         valueAsString = revertAsString
      }
   }
}

#elseif os(macOS)
extension FieldValue {
   private func editingChanged(_ isEditing: Bool) {
      self.editingInProgress = isEditing
      if editingInProgress {
         // when focus is acquired, give visual clue and disable Button in caller.
         foregroundColor = .red
         environment.commit = false
         revertAsString = valueAsString
      }
   }
}

#endif

//MARK: - Previews
struct FieldValue_Previews: PreviewProvider {
   static var previews: some View {
      VStack {
         FieldValue(value: .constant(123.45), invalid: .constant(false))
         FieldValue(value: .constant(67), invalid: .constant(false))
      }
      .environmentObject(FieldsEnvironment.singleton)
   }
}

