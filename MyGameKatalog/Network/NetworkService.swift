//
//  NetworkService.swift
//  MyGameKatalog
//
//  Created by Kevin Chilmi Rezhaldo on 12/07/22.
//

import Foundation
import Alamofire

var gameData: GamesResponse?

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    func callingGamesAPI(completion: @escaping(Bool) -> Void) {
        let gameUrl = URL(string: "https://api.rawg.io/api/games?key=ea0dc2b1bec04894a577891bdff084f6")
        
        AF.request(gameUrl!, method: .get).response (completionHandler: { response in
            guard let data = response.data else { return }
            
            do {
                let decoder = JSONDecoder()
                let gameResponse = try? decoder.decode(GamesResponse.self, from: data)
                print("Get DATA: \(gameResponse!)")
                gameData = gameResponse
                if response.response?.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        })
        
        
    }
}
