//
//  CoinImageVM.swift
//  CtyptoTracker
//
//  Created by Mustafo on 02/06/21.
//

import Foundation
import SwiftUI
import Combine


class CoinImageVM: ObservableObject {
    @Published var uiImage: UIImage?
    @Published var isLoading = true
    let imageService: CoinImageService
    let imageName: String
    let folderName = "coin_images"

    
    init(coin: CoinModel) {
        imageService = CoinImageService(urlString: coin.image)
        self.imageName = coin.id
        getImage()
    }
    
    private func getImage() {
        if let savedImage = LocalFileManager.instance.getSavedImage(imageName: imageName, folderName: folderName) {
            self.uiImage = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    var cancellables = Set<AnyCancellable>()
    
    private func downloadCoinImage() {
        imageService.$uiImage.sink { [weak self] downloadedImage in
            guard let image = downloadedImage,let self = self else { return }
            self.uiImage = image
            LocalFileManager.instance.saveImage(uiImage: image, imageName: self.imageName, folderName: self.folderName)
        }
        .store(in: &cancellables)
    }
}
