import SwiftUI

struct AddObservationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ObservationViewModel

    @State private var title = ""
    @State private var targetName = ""
    @State private var date = Date()
    @State private var locationName = "My Backyard"
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    @State private var telescope = ""
    @State private var mount = ""
    @State private var camera = ""
    @State private var filters = ""
    @State private var exposureInfo = ""
    @State private var stackingMethod = ""
    @State private var notes = ""
    @State private var imageDatas: [Data] = []

    var body: some View {
        Form {
            Section(header: Text("Basic Info")) {
                TextField("Title", text: $title)
                TextField("Target Name", text: $targetName)
                DatePicker("Date", selection: $date)
            }

            Section(header: Text("Location")) {
                TextField("Location Name", text: $locationName)
                TextField("Latitude", value: $latitude, format: .number)
                TextField("Longitude", value: $longitude, format: .number)
            }

            Section(header: Text("Equipment")) {
                TextField("Telescope", text: $telescope)
                TextField("Mount", text: $mount)
                TextField("Camera", text: $camera)
                TextField("Filters", text: $filters)
            }

            Section(header: Text("Exposure & Stacking")) {
                TextField("Exposure Info", text: $exposureInfo)
                TextField("Stacking Method", text: $stackingMethod)
            }

            Section(header: Text("Notes")) {
                TextEditor(text: $notes)
                    .frame(height: 100)
            }

            Section(header: Text("Photos")) {
                PhotoGalleryView(imageDatas: $imageDatas)
            }

            Button("Save Observation") {
                let observation = Observation(
                    title: title,
                    targetName: targetName,
                    date: date,
                    location: Location(name: locationName, latitude: latitude, longitude: longitude),
                    equipment: Equipment(telescope: telescope, mount: mount, camera: camera, filters: filters),
                    exposureInfo: exposureInfo,
                    stackingMethod: stackingMethod,
                    imageDatas: imageDatas,
                    notes: notes
                )
                viewModel.addObservation(observation)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("New Observation")
    }
}

