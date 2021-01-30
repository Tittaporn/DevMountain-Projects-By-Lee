//
//  ComicController.swift
//  MarvelDeck
//
//  Created by Lee McCormick on 1/30/21.
//

import UIKit

class ComicController {
    
    
    // MARK: - String Constants
    
    static let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public")
    static let comicsEndpoint = "comics"
    static let charactersKey = "characters"
    static let apiKeyKey = "apikey"
    static let publicAPIKey = "e757a5c4b010e88336e854ad7abb02e0"
    
    // NEED The timeStamp and hash for the API Authentication
    static let timeStampKey = "ts"
    static let timeStamp = "today"
    static let hashKey = "hash"
    static let privateKey = "c7c3f461b6e6fda972cb81e8e4e7b7b761383939"
    
    // MARK: - Methods
    // [Comic.Data.Result] //because we can use the keyword Result
    static func fetchMarvelCommics(characterID: String, completion: @escaping (Result<[Comic.Data.Result],NetworkError>) -> Void ) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let commicURL = baseURL.appendingPathComponent(comicsEndpoint)
        
        var components = URLComponents(url: commicURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: charactersKey, value: characterID),
            URLQueryItem(name: timeStampKey, value: timeStamp),
            URLQueryItem(name: apiKeyKey, value: publicAPIKey),
            URLQueryItem(name: hashKey, value: (timeStamp+privateKey+publicAPIKey).asMD5())
        ]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print("COMICS URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("COMICS RESPONSE STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let comic = try JSONDecoder().decode(Comic.self, from: data)
                let comics = comic.data.results
                return completion(.success(comics))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    } //End of func
    
    static func fetchThumbnail(for commic: Comic.Data.Result, completion: @escaping (Result<UIImage,NetworkError>) -> Void) {
        let baseURL = commic.thumbnail.path
        let finalURL = baseURL.appendingPathExtension(commic.thumbnail.extension)
        print("COMMIC IMAGE URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("COMIC IMAGE STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(thumbnail))
        }.resume()
    } //End of func 
} //End of class


/* NOTE THIS APP NEED ADJUST THE SECURE IN THE `info.plist`
 // App Transport Security Settings
 >> Allow Arbitrary Loads == YES
 //______________________________________________________________________________________
 */
