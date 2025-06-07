import SwiftUI
import PhotosUI

struct PhotoGalleryView: View {
    @Binding var imageDatas: [Data]
    @State private var selectedItems: [PhotosPickerItem] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Photos")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(imageDatas, id: \.self) { data in
                        if let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                                .clipped()
                        }
                    }
                }
            }

            PhotosPicker("Add Photos", selection: $selectedItems, matching: .images)
                .onChange(of: selectedItems) { newItems in
                    for item in newItems {
                        Task {
                            if let data = try? await item.loadTransferable(type: Data.self) {
                                imageDatas.append(data)
                            }
                        }
                    }
                }
        }
        .padding(.vertical, 8)
    }
}

