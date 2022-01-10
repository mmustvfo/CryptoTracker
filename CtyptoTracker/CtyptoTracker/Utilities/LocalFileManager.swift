//
//  LocalFileManager.swift
//  CtyptoTracker
//
//  Created by Mustafo on 04/06/21.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() { }
    
    func saveImage(uiImage: UIImage,imageName: String,folderName: String) {
        
        //creates a folder if doesn't exist
        createDirectoryIfNeeded(folderName: folderName)
        
        
        
        // get path for image
        guard let imageData = uiImage.pngData(),
              let url = getURLImage(imageName: imageName, folderName: folderName) else { return }
        createDirectoryIfNeeded(folderName: folderName)
        
        // saves image
        do  {
            try imageData.write(to: url)
        } catch let error {
            print("Erron in saving image. \(error.localizedDescription)")
        }
        
    }
    
    private func createDirectoryIfNeeded(folderName: String) {
        guard let url = getURLFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error while creating the directory.Path: \(url.path). \(error.localizedDescription) ")
            }
        }
    }
    
    private func getURLFolder(folderName: String) -> URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName)
    }
    
    private func getURLImage(imageName: String,folderName: String) -> URL? {
        guard let folderURL = getURLFolder(folderName: folderName) else { return nil}
        
        return folderURL.appendingPathComponent(imageName + "png")
    }
    
    func getSavedImage(imageName: String,folderName: String) -> UIImage? {
        guard let url = getURLImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path)
              else { return nil }
        
        return UIImage(contentsOfFile: url.path)
        
    }
}
