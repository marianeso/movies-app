//
//  FilmStorage.swift
//  MariFlix
//
//  Created by Wellington on 20/06/22.
//

import Foundation

class MovieStorage {
// MARK: - Private Variables

private let userDefaults: UserDefaults = UserDefaults.standard
private let movieKey: String = "movies"


// MARK: - Public Methods

// pega todos os movies do user default, decodifica e entrega para o usuario
func getMovies() -> [Int : LocalMovie]? {
    guard let storageNote = self.userDefaults.object(forKey: self.movieKey) as? Data else { return nil }
    let dictMovies = try? JSONDecoder().decode([Int : LocalMovie].self, from: storageNote)
    return dictMovies
}

// pega 1 movie específico
func getMovie(movieID: Int) -> LocalMovie? {
    let movies:[Int : LocalMovie]? = self.getMovies() ?? [:]
    
    return movies?[movieID]
}

// salva 1 movie específico. Vai pegar o movie, codificar e colocar no user default
func save(movieID: Int, movie: LocalMovie) {
    let movies:[Int : LocalMovie]? = self.getMovies() ?? [:]
    
    let combinedDict = movies?.merging([movieID : movie]) { $1 }
    
    let dataEncoded = try? JSONEncoder().encode(combinedDict)
    self.userDefaults.set(dataEncoded, forKey: self.movieKey)
}

// deleta 1 movie específico
func delete(movieID: Int) {
   var movies:[Int : LocalMovie]? = self.getMovies()
   
    movies?.removeValue(forKey: movieID)

   let dataEncoded = try? JSONEncoder().encode(movies)
   self.userDefaults.set(dataEncoded, forKey: self.movieKey)
    }
}
