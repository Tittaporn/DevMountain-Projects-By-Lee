//
//  MarvelCharacterController.swift
//  MarvelDeck
//
//  Created by Lee McCormick on 1/30/21.
//

import UIKit

class MarvelCharacterController {
    
    // MARK: - String Constants
    // https://gateway.marvel.com:443/v1/public/characters?name=thor&apikey=e757a5c4b010e88336e854ad7abb02e0
    static let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public")
    static let characterEndpoint = "characters"
    static let nameKey = "name"
    static let apiKeyKey = "apikey"
    static let publicAPIKey = "e757a5c4b010e88336e854ad7abb02e0"
    
    // NEED The timeStamp and hash for the API Authentication
    static let timeStampKey = "ts"
    static let timeStamp = "today"
    static let hashKey = "hash"
    static let privateKey = "c7c3f461b6e6fda972cb81e8e4e7b7b761383939"
    
    // MARK: - Methods
    static func fetchMarvelCharacter(searchTerm: String, completion: @escaping (Result<MarvelCharacter,NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.noData))}
        let charactersURL = baseURL.appendingPathComponent(characterEndpoint)
        
        // Another way to add component, Creat queryItems in the array
        var components = URLComponents(url: charactersURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: nameKey, value: searchTerm.lowercased()), //Should be smart by ..lowercased(),
            URLQueryItem(name: timeStampKey, value: timeStamp),
            URLQueryItem(name: apiKeyKey, value: publicAPIKey),
            
            // .asMD5()) From String Extension
            URLQueryItem(name: hashKey, value: (timeStamp+privateKey+publicAPIKey).asMD5())
        ]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print("CHARACTER URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("CHARACTER RESPONSE STATUS CODE: \(response.statusCode)") //Purple Codes are given by Apple.
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                
                
                let secondLevelObject = topLevelObject.data
                let marvelCharacters = secondLevelObject.results
                guard let firstMarvelCharacter = marvelCharacters.first else { return completion(.failure(.noData))}
                
                // This line is same as 3 lines up there ^^^
                // let firstMarvelCharacter = topLevelObject.data.results[0]
                
                return completion(.success(firstMarvelCharacter))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchThumbnail(for character: MarvelCharacter, completion: @escaping (Result<UIImage,NetworkError>) -> Void) {
        let baseURL = character.thumbnailInfo.path
        let finalURL = baseURL.appendingPathExtension(character.thumbnailInfo.extension)
        print("IMAGE URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("CHARACTER IMAGE RESPONSE CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.noData))}
            
            completion(.success(thumbnail))
        }.resume()
    }
} //End of class

/* NOTE
 
 https://developer.marvel.com/docs
 
 https://developer.marvel.com/documentation/authorization
 
 This Marvel API Require to me a hash...
 
 Authentication for Server-Side Applications
 Server-side applications must pass two parameters in addition to the apikey parameter:
 ts - a timestamp (or other long string which can change on a request-by-request basis)
 hash - a md5 digest of the ts parameter, your private key and your public key (e.g. md5(ts+privateKey+publicKey)
 
 md5 >> It is a hash ??? Move Every letter forward ex. C = E, A = C
 
 
 //______________________________________________________________________________________
 */
