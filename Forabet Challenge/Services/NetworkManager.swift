//
//  NetworkManager.swift
//  Forabet Challenge
//
//  Created by SV on 13.04.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () { }
    
    func isPathOpen(for url: String, completion: @escaping (_ responseClo: Bool) -> Void) {
        
        let session = URLSession.shared
        guard let url = URL(string: url) else { return }
        session.dataTask(with: url) { _, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                completion(true)
            } else { completion(false) }
        }.resume()
    }
}
