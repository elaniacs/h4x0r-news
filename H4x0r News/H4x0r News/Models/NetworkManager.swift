//
//  NetworkManager.swift
//  H4x0r News
//
//  Created by Cáren Sousa on 23/09/22.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}



/*
 No momento em que usamos o @Published, sempre precisamos garantir que busquemos a thread principal. Portanto, temos que acessar o dispatchQueue.main.async. Se não fizer isso, vc receberá um erro no console. Mas, efetivamente, é pq essa propriedade(@Published var posts = [Post]()) é uma propriedade que outros objetos estão ouvindo. Esta atualização dee ocorrer no segmento principal. Se isso ocorrer em segundo plano, nossa exibição de conteúdo será notificada em tempo hábil. 
 */
