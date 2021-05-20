# SwiftUIFields

SwiftUIFields provides a number of customised views to assist in typed and validated data entry to both macOS and iOS apps. They are intended as substitutes for the less functional TextField() which handles only String values.

The basic View is:

    Field(value: Binding,
          caption: String = "",
          subcaption: String = "",
          validator: FieldValidator? = nil) -> Field

This takes a value of any type (T : FieldProtocol) with optional caption and subcaption and a validation closure and displays a text field which collects data of type T. If invalid data is entered, or if data entry is abandoned (by transferring focus to another control) the value reverts to its original value and an error message appears below it if one is specified with the FieldValidator closure.

The FieldProtocol determines what types can be handled by a Field(). The requiredments are minimal: a failable initialised which takes a string which can be interpreted as the value and a method which converts a value to such a String. Extensions which make common types (Int, Double, Float, CGFloat, Range, Closed Range) conform are included in the Package. to FieldProtocol

    public protocol FieldProtocol {
        init?(_ string: String) // already conformed to by most types
        func stringified() -> String
    }

A FieldValidator is a struct which combines a closure with an error message:

    FieldValidator(validator: (T) -> Bool,
                   errorMessage: String) -> FieldValidator

The closure takes a value and returns true (valid) or false (invalid).
