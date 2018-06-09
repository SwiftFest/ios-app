//
//  APIClient.swift
//  SwiftFest
//
//  Created by Zev Eisenberg on 6/9/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import Foundation

enum Result<Value, Error> {
    case success(value: Value)
    case failure(Error)
}

class APIClient {

    struct APIError: Error {
        let underlying: Error?
    }

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        return URLSession(configuration: config)
    }()

    let baseUrl: String

    init(baseUrl: String = "http://swiftfest.io") {
        self.baseUrl = baseUrl
    }

    func fetchAgenda(using completionHandler: @escaping (Result<Agenda, APIError>) -> Void) {
        let url = URL(string: "\(baseUrl)/schedule.json")!
        let fetchDataTask = dataTask(for: url, using: completionHandler)
        fetchDataTask.resume()
    }

    func fetchSessions(using completionHandler: @escaping (Result<[Session], APIError>) -> Void) {
        let url = URL(string: "\(baseUrl)/sessions.json")!
        let fetchDataTask = dataTask(for: url, using: completionHandler)
        fetchDataTask.resume()
    }

    func fetchSpeakers(using completionHandler: @escaping (Result<[Speaker], APIError>) -> Void) {
        let url = URL(string: "\(baseUrl)/speakers.json")!
        let fetchDataTask = dataTask(for: url, using: completionHandler)
        fetchDataTask.resume()
    }

    func fetchTeam(using completionHandler: @escaping (Result<[TeamMember], APIError>) -> Void) {
        let url = URL(string: "\(baseUrl)/team.json")!
        let fetchDataTask = dataTask(for: url, using: completionHandler)
        fetchDataTask.resume()
    }

}

private extension APIClient {
    func dataTask<DataType: Decodable>(for url: URL,
                                       using completionHandler: @escaping (Result<DataType, APIError>) -> Void) -> URLSessionDataTask {
        let dataTask = session.dataTask(with: url) { data, _, _ in
            do {
                let value = try JSONDecoder().decode(DataType.self, from: data!)
                completionHandler(.success(value: value))
            } catch {
                completionHandler(.failure(APIError(underlying: error)))
            }
        }

        return dataTask
    }
}
