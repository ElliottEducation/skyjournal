import SwiftUI

@main
struct SkyJournalApp: App {
    @StateObject var observationVM = ObservationViewModel()

    var body: some Scene {
        WindowGroup {
            ObservationListView()
                .environmentObject(observationVM)
        }
    }
}

