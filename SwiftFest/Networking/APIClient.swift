//
//  APIClient.swift
//  SwiftFest
//
//  Created by Zev Eisenberg on 6/9/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import AlamofireImage
import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

extension Result {

    var value: Value? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }

    var error: Error? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }

    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }

    var isFailure: Bool {
        return !isSuccess
    }

}

struct UnknownError: Error {}

class APIClient {

    static let shared = APIClient()

    private let session: URLSession

    private let baseUrl: URL

    init(baseUrl: URL = URL(string: "http://swiftfest.io")!, configuration: URLSessionConfiguration = .default) {
        self.baseUrl = baseUrl
        self.session = URLSession(configuration: configuration)
    }

    func fetchAgenda(using completionHandler: @escaping (Result<Agenda>) -> Void) {
        let url = URL(string: "\(baseUrl)/\(Endpoint.schedule).json")!
        let fetchDataTask = dataTask(for: url, using: completionHandler)
        fetchDataTask.resume()
    }

    func fetchSessions(using completionHandler: @escaping (Result<[Session]>) -> Void) {
        let url = URL(string: "\(baseUrl)/\(Endpoint.sessions).json")!
        let fetchDataTask = dataTask(for: url, using: completionHandler)
        fetchDataTask.resume()
    }

    func fetchSpeakers(using completionHandler: @escaping (Result<[Speaker]>) -> Void) {
        let url = URL(string: "\(baseUrl)/\(Endpoint.speakers).json")!
        let fetchDataTask = dataTask(for: url, using: completionHandler)
        fetchDataTask.resume()
    }

    func fetchTeam(using completionHandler: @escaping (Result<[TeamMember]>) -> Void) {
        let url = URL(string: "\(baseUrl)/\(Endpoint.team).json")!
        let fetchDataTask = dataTask(for: url, using: completionHandler)
        fetchDataTask.resume()
    }

    func loadPersonImage(named name: String, into imageView: UIImageView, completionHandler: ((Result<Void>) -> Void)?) {
        let imageUrl = baseUrl.appendingPathComponent("img/people/\(name)")
        imageView.af_setImage(withURL: imageUrl, placeholderImage: UIImage(named: name)) { response in
            switch response.result {
            case .success: completionHandler?(.success(()))
            case .failure(let error): completionHandler?(.failure(error))
            }
        }
    }

}

private extension APIClient {
    func dataTask<DataType: Decodable>(for url: URL,
                                       using completionHandler: @escaping (Result<DataType>) -> Void) -> URLSessionDataTask {
        let dataTask = session.dataTask(with: url) { data, _, error in
            var responseData: Data
            
            if data == nil {
                guard let cachedData = Cache().getFile(named: url.lastPathComponent) else {
                    completionHandler(.failure(error ?? UnknownError()))
                    return
                }
                
                responseData = cachedData
            } else {
                responseData = data!
            }

            do {
                let value = try JSONDecoder.default.decode(DataType.self, from: responseData)
                Cache().save(response: responseData, to: url.lastPathComponent)
                completionHandler(.success(value))
            } catch {
                completionHandler(.failure(error))
            }
        }

        return dataTask
    }
}
