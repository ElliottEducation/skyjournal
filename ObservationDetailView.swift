import SwiftUI

struct ObservationDetailView: View {
    let observation: Observation

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(observation.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Date: \(observation.date.formatted(.dateTime.year().month().day()))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Divider()

                Group {
                    Text("Target: \(observation.targetName)")
                    Text("Exposure: \(observation.exposureInfo)")
                    Text("Stacking: \(observation.stackingMethod)")
                }

                Divider()

                Group {
                    Text("Telescope: \(observation.equipment.telescope)")
                    Text("Mount: \(observation.equipment.mount)")
                    Text("Camera: \(observation.equipment.camera)")
                    Text("Filters: \(observation.equipment.filters)")
                }

                Divider()

                Text("Location: \(observation.location.name)")
                Text("Lat: \(observation.location.latitude), Lon: \(observation.location.longitude)")
                    .font(.footnote)
                    .foregroundColor(.gray)

                Divider()

                if !observation.imageDatas.isEmpty {
                    Text("Photos")
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(observation.imageDatas, id: \.self) { data in
                                if let image = UIImage(data: data) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }

                Divider()

                if !observation.notes.isEmpty {
                    Text("Notes")
                        .font(.headline)
                    Text(observation.notes)
                        .font(.body)
                        .padding(.top, 4)
                }
            }
            .padding()
        }
        .navigationTitle("Observation Detail")
        .toolbar {
            NavigationLink(destination: ExportView(observation: observation)) {
                Label("Export", systemImage: "square.and.arrow.up")
            }
        }
    }
}

