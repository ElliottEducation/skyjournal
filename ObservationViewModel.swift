import Foundation
import SwiftUI

class ObservationViewModel: ObservableObject {
    @Published var observations: [Observation] = []

    private let filename = "observations.json"

    init() {
        loadFromFile()
    }

    func addObservation(_ observation: Observation) {
        observations.append(observation)
        saveToFile()
    }

    func deleteObservation(at offsets: IndexSet) {
        observations.remove(atOffsets: offsets)
        saveToFile()
    }

    // MARK: - FileManager paths

    private var fileURL: URL {
        let manager = FileManager.default
        let urls = manager.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0].appendingPathComponent(filename)
    }

    // MARK: - Save to JSON

    func saveToFile() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(observations)
            try data.write(to: fileURL, options: [.atomicWrite])
            print("✅ Saved observations to \(fileURL)")
        } catch {
            print("❌ Failed to save observations: \(error)")
        }
    }

    // MARK: - Load from JSON

    func loadFromFile() {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoded = try JSONDecoder().decode([Observation].self, from: data)
            self.observations = decoded
            print("📂 Loaded \(observations.count) observations from file.")
        } catch {
            print("⚠️ No existing file found or failed to load: \(error)")
        }
    }
}

