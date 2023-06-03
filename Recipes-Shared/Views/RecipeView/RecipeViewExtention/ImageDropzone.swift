//
//  ImageDropzone.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-29.
//

import SwiftUI
import PhotosUI

struct DropZoneView: View {
    @State var selectedItems: PhotosPickerItem? = nil
    @Binding var image: UIImage?
    @State private var isShowingFilePicker = false
    @State private var isShowingPhotoLibrary = false
    var fillColor: Color

    var body: some View {
        VStack {
            if let image = image {
                ImageView(image: Image(uiImage: image), backgroundColor: fillColor, cornerRadius: 10)
                    .cornerRadius(5)
                    .frame(width: 200, height: 200)
                    .onDrop(of: ["public.image"], isTargeted: nil) { providers in
                        guard let provider = providers.first else { return false }
                        importImage(from: provider)
                        return true
                    }
                
            } else {
                Rectangle()
                    .fill(fillColor)
                    .cornerRadius(5)
                    .frame(width: 200, height: 200)
                    .overlay(Text("Drop Image Here")
                        .foregroundColor(.white))
                    .onDrop(of: ["public.image"], isTargeted: nil) { providers in
                        guard let provider = providers.first else { return false }
                        importImage(from: provider)
                        return true
                    }
            }
            
            HStack {
                Button("Browse", action: {
                    isShowingFilePicker = true
                })
                .buttonStyle(.bordered)
                .padding(.top, 10)
                .fileImporter(isPresented: $isShowingFilePicker, allowedContentTypes: [.image]) { result in
                    if case .success(let url) = result {
                        importImage(from: url)
                    }
                }
                
                Button("Photo Library", action: {
                    isShowingPhotoLibrary = true
                })
                .buttonStyle(.bordered)
                .padding(.top, 10)
                .sheet(isPresented: $isShowingPhotoLibrary) {
                    /*ImagePicker(sourceType: .photoLibrary) { image in
                        self.image = image
                    }*/
                    PhotosPicker(selection: $selectedItems, matching: .playbackStyle(.image), preferredItemEncoding: .compatible) {
                        
                    }
                }
            }
        }
    }
    
    private func importImage(from itemProvider: NSItemProvider) {
        itemProvider.loadObject(ofClass: UIImage.self) { object, error in
            if let image = object as? UIImage {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }

    private func importImage(from url: URL) {
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            self.image = image
        }
    }
}
