import SwiftGodotRuntime
import SwiftUI
import UIKit


@Godot
class SwiftGodotAppleTemplate: RefCounted, @unchecked Sendable {
    @Signal var greeted: SignalWithArguments<String>

    // This exposes the function 'sayHello' that returns a String back to Godot
    @Callable
    func sayHello(name: String) -> String {
        return "Hello, \(name)!"
    }

    // This shows how to present a window that covers the entire screen
    // the method can be used to present other SwiftUI views:
    @Callable()
    func showWindow(text: String) {
        DispatchQueue.main.async {
            presentSwiftUIOverlayFromTopMost(GreetView())
        }
    }

    // Waits for 2 seconds and then emits a signal
    @Callable()
    func queueCallback() {
        Task {
            try await Task.sleep(for: .seconds(2))
            DispatchQueue.main.async {
                self.greeted.emit("Hello there, 2 seconds have passed.")
            }
        }
    }
}

struct GreetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack(spacing: 16) {
                Text("Hello from SwiftUI")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Showing you some nice UI")

                Button("Return") {
                    dismiss()
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
        }
    }
}

// The name below should match the value in the .gdextesion file in addons
// for the "entry_symbol" value:
#initSwiftExtension(cdecl: "template_entry_point", types: [
    SwiftGodotAppleTemplate.self,
    GameCenterManager.self
])

