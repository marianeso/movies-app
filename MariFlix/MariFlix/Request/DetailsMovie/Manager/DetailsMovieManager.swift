//
//  DetailsMovieManager.swift
//  MariFlix
//
//  Created by Wellington on 24/06/22.
//

import Foundation

// com completion

final class DetailsMovieManager {
    
    private let urlInicial = "https://api.themoviedb.org/3/movie/"
    private let api_key = "?api_key=19649d836ff40809b43e658f81b875dc"
    private var urlStringDetailsMovie: String = ""
    
    // completion ---- handler: @escaping ()->Void
    func fetchDetailsMovieWithCompletion(movieID: String, completion: @escaping (DetailsMovieResponse?)->Void) {
        
        self.urlStringDetailsMovie = self.urlInicial + movieID + self.api_key

        //urlCOmponents: URL customizada
        guard let url = URL(string: urlStringDetailsMovie) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        //completion: estou aguardando a resposta do servidor. Funcao para fazer a requisicao para o servidor, pedir um dado.
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //transformacao. DE PARA. DE dados do JSON para o response (classe principal), onde ficara armazenado os dados
            //PopularMovieResponse: Pega o dado da requicao, parce do dado completo.
            //Completion (nil): Se o response der erro, a completion vai retornar nulo
            guard let data = data,
                    let response = try? JSONDecoder().decode(DetailsMovieResponse.self, from: data) else {
                        completion(nil)
                return
            }
            
            //avisar e devolver para a classe que esta esperando o dado que ele chegou
            //response é a variavel que pega a requisicao.
            completion(response)
        }
        task.resume()
    }
}

