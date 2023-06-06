//
//  DefaultNetworkRepository.swift
//  Service
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

public final class DefaultNetworkRepository: NetworkRepository {

    public init() {}

    public func request<T: Codable>(endpoint: String, path: String, resultObject: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = endpoint
        urlComponents.path = path
        let url = urlComponents.url!

        task(with: url, completion: completion)
    }

    public func request(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(filePath: url)

        URLSession.shared.dataTask(with: url) { data, _, err in
            if let err = err {
                completion(.failure(err))
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }

    private func task<T: Codable>(with url: URL, completion: @escaping (Result<T?, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, err in
            if let err = err {
                completion(.failure(err))
            }
            if let data = data {
                do {
                    let decode = JSONDecoder()
                    let value = try decode.decode(T.self, from: data)
                    completion(.success(value))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
