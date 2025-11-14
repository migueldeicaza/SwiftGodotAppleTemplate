This directory contains a template to create lightweight
SwiftGodot-based extensions that can be used in your Godot game to
access system APIs.

This template, rather than using the entire SwiftGodot API that can be
quite large, it only uses the more compact SwiftGodotRuntime which is
intended to be used for interoperability with Godot.

# Building and Packaging the Extension

The Makefile target `xcframework` will build your iOS framework that
you can include with Godot and put it inside the `addons` directory.

Then copy this `addons` directory into your project and you can
instantiate and invoke methods from your sample.

# Using the Extension

In your project, add the contents of the `addons` directory into your
project `addons` directory.   Then export your project to iOS.

You will need to do two things to your exported project in Xcode, Go
to "Targets", select the target, and then go to "Build Phases" and then:

    * Link Binary with Libraries: add the SwiftGodotAppleTemplate.xcframework

    * Embed Frameworks: add the SwiftGodotAppleTempalte.xcframework

Once [this Godot PR is merged](https://github.com/godotengine/godot/issues/112783) 
the first step should not be necessary.   The second step I believe is a 
separate bug/issue.

# What is going on.

The extension is implemented using SwiftPM, and this contains a single
target, the "SwiftGodotAppleTemplate" library.  This library defines
one class with the same name that surfaces one method to Godot `sayHello`:

```swift
@Godot
class SwiftGodotAppleTemplate: RefCounted {

    @Callable
    /// This exposes the function 'sayHello' that returns a String back to Godot
    func sayHello(name: String) -> String {
        return "Hello \(name)"
    }
}
```

We link this to Godot by declaring in the
`swiftgodotappletemplate.gdextension` that our entry point is
`template_entry_point`, and in our Swift source, we call this macro
that performs this registation:

```swift
#initSwiftExtension(cdecl: "template_entry_point", types: [SwiftGodotAppleTemplate.self])
```

This class exposes one method, "sayHello", which is exported to Godot,
and you can call with a string parameter, and returns a String.

# Testing Locally

The directory "Demo" contains a trivial Godot sample that shows how to
call the method from GDScript.
