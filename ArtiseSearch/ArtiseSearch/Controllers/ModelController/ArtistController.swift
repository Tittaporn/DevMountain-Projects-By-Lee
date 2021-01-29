//
//  ArtistController.swift
//  ArtiseSearch
//
//  Created by Lee McCormick on 1/28/21.
//

import Foundation

// https://api.musixmatch.com/ws/1.1/artist.search?q_artist=sam&apikey=7c69e27301441fe3d6fc6a977b97fb53

class ArtistController {
    
    static let baseURL = URL(string: "https://api.musixmatch.com/ws/1.1/")
    static let artistSearchComponent = "artist.search"
    static let qArtistQueryString = "q_artist"
    static let apiKeyString = "apikey"
    static let apiKeyValue = "7c69e27301441fe3d6fc6a977b97fb53"
    
    static func fetchArtist(WithSearchTerm: String, completion: @escaping (Result<[Artist], ArtistError>) -> Void) {
        guard let baseURL = baseURL else {return(completion(.failure(.invalidURL)))}
        let artistSearchURL = baseURL.appendingPathComponent(artistSearchComponent)
        
        var components = URLComponents(url: artistSearchURL, resolvingAgainstBaseURL: true)
        let artistSearchQuery = URLQueryItem(name: qArtistQueryString, value: WithSearchTerm)
        let apiKeyQuery = URLQueryItem(name: apiKeyString, value: apiKeyValue)
        components?.queryItems = [artistSearchQuery, apiKeyQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print("\nFinalURL for fetchArtist ::: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("FETCH ARTIST STATUS CODE : \(response)")
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let artistOjects = topLevelObject.message.body.artistList
                
                // Look deeper for artises by using for loop.
                var artists: [Artist] = []
                
                for object in artistOjects {
                    let artist = object.artist
                    artists.append(artist)
                }
                return completion(.success(artists)) //No return needed, do the same job because we don't need to do anything else. UNLESS WE NEED TO PRINT OR DO SOMETHING ELSE AT THE END OF THE FUNCTION.
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
}
