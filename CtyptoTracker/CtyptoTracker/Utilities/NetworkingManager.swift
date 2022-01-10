//
//  NetworkingManager.swift
//  CtyptoTracker
//
//  Created by Mustafo on 01/06/21.
//

import Foundation
import Combine

struct NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badUrlResponse(url: URL)
        case uknown
        
        var errorDescription: String? {
            switch self {
            case .badUrlResponse(url: let url):
                return "[🔥]Bad response from URL: \(url)"
            case .uknown:
                return "[⚠️] Uknown Error"
            }
        }
    }
    
    static func downloadFromUrl(url: URL) -> AnyPublisher<Data,Error>{
         return URLSession.shared.dataTaskPublisher(for: url)
             .tryMap { try responseHandler(output: $0, url: url) }
             .retry(3)
            .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher()
    }
    
    static func responseHandler(output: URLSession.DataTaskPublisher.Output,url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,response.statusCode >= 200 && response.statusCode <= 300 else {
            throw NetworkingError.badUrlResponse(url: url) }
        
        return output.data
    }
    
    
    static func completionHandler(_ completion:Subscribers.Completion<Error>) {
        switch completion {
        case .finished : break
        case .failure(let error): print("Error \(error.localizedDescription)")
        }
    }
}
