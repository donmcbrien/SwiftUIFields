# SwiftUIFields

<img src="ScreenShot.png"/>

## Components
SwiftUIFields provides two customised views to assist in collecting typed and validated data in a user interface for both macOS and iOS apps. They are intended as more flexible substitutes for the less functional TextField() which handles only String values.

The Views are:

    Field(value: Binding<T>,
          caption: String = "",
          subcaption: String = "",
          validator: FieldValidator<T>? = nil) -> Field

and

    FieldsButton(values: Binding<[T]>,
                 caption: String = "",
                 subcaption: String = "",
                 imageName: String = "list.bullet.rectangle",
                 fieldValidator: FieldValidator<T>? = nil,
                 sheetValidator: SheetValidator<T>? = nil) -> FieldsButton

Most parameters have default values making usage very simple.

A Field() presents a "textfield-like" control which can collect any datatype which conforms to FieldsProtocol with an optional caption, subcaption and validation closure. If valid data is committed (i.e. <enter> pressed) it is propagated to the source of truth. If invalid data is committed, the field reverts to its original value. 

NB: In iOS, if the field is abandoned (i.e. focus transferred to another control) the field reverts to its original value. In macOS, this case is handled as if <enter> were pressed.

A FieldsButton() presents a sheet of "textfield-like" controls which can collect an array of any datatype which conforms to FieldsProtocol with an optional caption, subcaption, buttonimage and both field and collection-wide validation closures. Individual Field()s are treated as described above. The sheet cannot be committed while its contents do not pass sheet validation.

The requirements of FieldProtocol are minimal:

    public protocol FieldProtocol {
        init?(_ string: String) // already conformed to by most types
        func stringified() -> String
    }

1) a failable initialiser which takes a string and turns it into a valid instance of the type or fails and
2) a method which turns a valid instance of the type into a string.
Extensions which make common types (Int, Double, Float, CGFloat, Range, Closed Range) conform are included in the Package.


FieldValidator and SheetValidator are structs which combines a closure with an error message:

    FieldValidator(validator: (T) -> Bool,
                   errorMessage: String) -> FieldValidator

    SheetValidator(validator: ([T]) -> Bool,
                   errorMessage: String) -> SheetValidator

The closure takes a value and returns true (i.e. valid) or false (i.e. invalid).

## Usage
Assuming an ObservableObject called viewModel with properties name:String, age:Int, salary:Double and childrensAges:[Int], the following code will produce the device screen displayed:

    VStack(alignment: .trailing) {
       Field(value: $viewModel.string,
             caption: "Name",
             fieldValidator: FieldValidator({ str in (str.count > 3) },
                                        "Must have > 3 characters"))
       Field(value: $viewModel.number,
             caption: "Salary")
       Field(value: $viewModel.integer,
             caption: "Age",
             subcaption: "(Negative)",
             fieldValidator: FieldValidator({ v in v > 21 },
                                            "Must exceed 21") )
       FieldsButton(values: $viewModel.intArray,
                    caption: "Children's Ages",
                    imageName: "rectangle.split.3x3.fill",
                    fieldValidator: FieldValidator({ v in v < 18 },
                                                   "Must be under 18"))
    }


## Installation
Add this Swift package in Xcode using its Github repository url. (File > Swift Packages > Add Package Dependency ...)

## Author
Don McBrien - email: don.mcbrien@icloud.com

## License
SwiftUICharts is provided subject to the license. See the LICENSE file.
