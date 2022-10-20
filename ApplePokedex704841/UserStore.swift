//
//  UserStore.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 12/10/2022.
//

import Foundation

final class UserStore {
    private let FAV_KEY = "fav_key"
    
    func setFavorites(items: Set<Int>) {
        UserDefaults.standard.set(Array(items), forKey: FAV_KEY)
    }
    
    func loadFavorites() -> Set<Int> {
        return Set(UserDefaults.standard.array(forKey: FAV_KEY) as? [Int] ?? [Int]())
    }
}
