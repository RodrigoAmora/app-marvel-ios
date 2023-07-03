//
//  CharacterService.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation
import Alamofire

class CharacterService {
    
    // MARK: - Atributes
    private let baseURL = "https://gateway.marvel.com/v1/public/"
    private let apiKey = "d17cef9472abf96413048a10bf24e04a"
    private let md5Hash = "cd79db65cd307fc9503bdadcfd9179e2"
    
    // MARK: - Methods
    func getCharacters(completion: @escaping(_ characterResponse: CharacterResponse, _ error: Int?) -> Void) {
        let path = "characters?ts=1"+"&apikey="+apiKey+"&hash="+md5Hash
        
        AF.request(baseURL+path,
                           method: .get,
                           encoding: URLEncoding.default)
                    .responseJSON{ response in
                        switch response.result {
                            case .success(let json):
                                switch response.response?.statusCode {
                                    case 200:
                                        guard let data = response.data else { return }
                                        do {
                                            let characterList = try JSONDecoder().decode(CharacterResponse.self, from: data)
                                            
                                            completion(characterList, nil)
                                        } catch {
                                            print("Error retriving questions \(error)")
                                            completion(CharacterResponse(), 0)
                                        }
                                        break
                                   
                                    case 403:
                                        completion(CharacterResponse(), 430)
                                        break
                                    
                                    case 500:
                                        completion(CharacterResponse(), 500)
                                        break
                                    
                                    default:
                                        completion(CharacterResponse(), 0)
                                        break
                                }
                            
                            case .failure(let error):
                                completion(CharacterResponse(), 0)
                                break
                        }
                    }
    }
    
    func getCharactersByName(name: String, completion: @escaping(_ characterResponse: CharacterResponse, _ error: Int?) -> Void) {
        let path = "characters?ts=1"+"&apikey="+apiKey+"&hash="+md5Hash+"&name="+name
        
        AF.request(baseURL+path,
                           method: .get,
                           encoding: URLEncoding.default)
                    .responseJSON{ response in
                        switch response.result {
                            case .success(let json):
                                switch response.response?.statusCode {
                                    case 200:
                                        guard let data = response.data else { return }
                                        do {
                                            let characterList = try JSONDecoder().decode(CharacterResponse.self, from: data)
                                            
                                            completion(characterList, nil)
                                        } catch {
                                            print("Error retriving questions \(error)")
                                            completion(CharacterResponse(), 0)
                                        }
                                        break
                                   /*
                                    case 403:
                                        completion(CharacterResponse(0, nil, ""), 403)
                                        break
                                    
                                    case 500:
                                        completion(CharacterResponse(0, nil, ""), 500)
                                        break
                                    */
                                    default:
                                        completion(CharacterResponse(), 0)
                                        break
                                }
                            
                            case .failure(let error):
                                completion(CharacterResponse(), 0)
                                break
                        }
                    }
    }
}
