//
//  UserDefaults.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 12/10/2022.
//

import Foundation

final class UserPrefs {
    private let FAV_KEY = "fav_key"
    
    func addFavorite(item: Int) {
        var array = getFavorite()
        array.insert(item)
        UserDefaults.standard.set(array, forKey: FAV_KEY)
    }
    
    func getFavorite() -> Set<Int> {
        return Set(UserDefaults.standard.array(forKey: FAV_KEY) as? [Int] ?? [Int]())
    }
}
