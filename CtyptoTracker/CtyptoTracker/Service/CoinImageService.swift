//
//  CoinImageService.swift
//  CtyptoTracker
//
//  Created by Mustafo on 02/06/21.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var uiImage: UIImage?
    
    init(urlString: String) {
        getImage(urlString: urlString)
    }
    
    var imageResponseCancellable: AnyCancellable?
    
    private func getImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        imageResponseCancellable = NetworkingManager.downloadFromUrl(url: url)
            .tryMap { data in
                return UIImage(data: data)
            }

            .sink(receiveCompletion: NetworkingManager.completionHandler) {
                 [weak self] image in
                self?.uiImage = image
                self?.imageResponseCancellable?.cancel()
            }
    }
}
