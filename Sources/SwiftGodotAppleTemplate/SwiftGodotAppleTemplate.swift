import SwiftGodotRuntime

@Godot
class SwiftGodotAppleTemplate: RefCounted {

    @Callable
    /// This exposes the function 'sayHello' that returns a String back to Godot
    func sayHello(name: String) -> String {
        return "Hello \(name)"
    }
}

// The name below should match the value in the .gdextesion file in addons
// for the "entry_symbol" value:
#initSwiftExtension(cdecl: "template_entry_point", types: [SwiftGodotAppleTemplate.self])

