//
//  movieManager.swift
//  MariFlix
//
//  Created by Wellington on 17/06/22.
//

import Foundation

// com completion

final class PopularMovieManager {
    
    private let urlStringPopMovie = "https://api.themoviedb.org/3/movie/popular?api_key=19649d836ff40809b43e658f81b875dc"
    
    // completion ---- handler: @escaping ()->Void
    func fetchPopularMovieWithCompletion(completion: @escaping ([Movie]?)->Void) {

        //urlCOmponents: URL customizada
        guard let url = URL(string: urlStringPopMovie) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        //completion: estou aguardando a resposta do servidor. Funcao para fazer a requisicao para o servidor, pedir um dado(data).
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //transformacao. DE PARA. DE dados do JSON para o response (classe principal), onde ficara armazenado os dados
            //PopularMovieResponse: Pega o dado da requicao, parce do dado completo.
            //Completion (nil): Se o response der erro, a completion vai retornar nulo
            guard let data = data,
                    let popularMovieResponse = try? JSONDecoder().decode(PopularMovieResponse.self, from: data) else {
                        completion(nil)
                return
            }
            
            //avisar e devolver para a classe que esta esperando o dado que ele chegou
            //popularMovieResponse é a variavel que pega a requisicao, e o .results é o [PopularMovie] que definimos no parametro acima.
            completion(popularMovieResponse.results)
        }
        task.resume()
    }
    
}

