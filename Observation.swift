import Foundation
import CoreLocation

struct Observation: Identifiable, Codable {
    var id = UUID()
    var title: String
    var targetName: String
    var date: Date
    var location: Location
    var equipment: Equipment
    var exposureInfo: String
    var stackingMethod: String
    var imageDatas: [Data]
    var notes: String
}

