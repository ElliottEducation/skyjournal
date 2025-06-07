import SwiftUI

struct ExportView: View {
    let observation: Observation
    @State private var markdownText: String = ""
    @State private var showShareSheet = false
    @State private var exportURL: URL?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Markdown Preview")
                .font(.headline)

            ScrollView {
                Text(markdownText)
                    .font(.system(.body, design: .monospaced))
                    .padding()
            }

            Spacer()

            HStack {
                Button("Generate Markdown") {
                    markdownText = MarkdownExporter.generateMarkdown(from: observation)
                }

                Button("Export .md") {
                    exportMarkdownFile()
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Export")
        .sheet(isPresented: $showShareSheet) {
            if let url = exportURL {
                ShareSheet(activityItems: [url])
            }
        }
    }

    func exportMarkdownFile() {
        let markdown = MarkdownExporter.generateMarkdown(from: observation)
        let fileName = observation.title.replacingOccurrences(of: " ", with: "_") + ".md"
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent(fileName)

        do {
            try markdown.write(to: fileURL, atomically: true, encoding: .utf8)
            exportURL = fileURL
            showShareSheet = true
        } catch {
            print("Export failed: \(error)")
        }
    }
}

