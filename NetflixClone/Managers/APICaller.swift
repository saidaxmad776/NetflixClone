//
//  APICaller.swift
//  NetflixClone
//
//  Created by Test on 06/09/22.
//

import Foundation
import UIKit

struct Constants {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyBQgbMvoYGSgtCBDqwxOy_Sp_DfHHN9CKI"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    
    static let shared = APICaller()
    
    // ---------------------------------------------------------------------------------------------------------------------------------
    
    func getTrendingMovies(complection: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complection(.success(results.results))
            } catch {
                complection(.failure(APIError.failedTogetData))
            }
            
        }
        task.resume()
    }
    // ---------------------------------------------------------------------------------------------------------------------------------

    func getTrendingTvs(complection: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complection(.success(results.results))
            } catch {
                complection(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
   // ---------------------------------------------------------------------------------------------------------------------------------
    
    func getUpcomingMovies(complection: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complection(.success(results.results))
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------

    func getPopular(complection: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1")
        else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complection(.success(results.results))
            } catch {
                complection(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------

    func getTopRated(complection: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1")
        else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complection(.success(results.results))
            } catch {
                complection(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------
    
    func getDiscoverMovies(complection: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")
        else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complection(.success(results.results))
            } catch {
                complection(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------

    func search(with query: String, complection: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)")
        else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complection(.success(results.results))
            } catch {
                complection(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getMovie(with query: String, complection: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponce.self, from: data)
                complection(.success(results.items[0]))
            } catch {
                complection(.failure(error))
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
