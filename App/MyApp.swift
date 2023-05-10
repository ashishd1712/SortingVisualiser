import SwiftUI

@available(iOS 16.0, *)
@main
struct MyApp: App {
    @StateObject var change = ViewChanger()
    var body: some Scene {
        WindowGroup {
            ResponsiveView{properties in
                MainView(layoutProperties: properties, algo: .BubbleSort, algorithm: algorithm)
                    .environmentObject(change)
            }
        }
    }
}
