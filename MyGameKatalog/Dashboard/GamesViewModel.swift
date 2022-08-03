//
//  GamesViewModel.swift
//  MyGameKatalog
//
//  Created by Kevin Chilmi Rezhaldo on 12/07/22.
//

import Foundation

final class GamesViewModel {
    var error: ObservableObject<String?> = ObservableObject(nil)
    
    func getData() {
        NetworkService.shared.callingGamesAPI{ [weak self] success in
            self?.error.value = success ? nil : "Invalid Data"
            
        }
    }
    
}
