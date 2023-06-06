//
//  DefaultNetworkRepository.swift
//  Service
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

public final class DefaultNetworkRepository: NetworkRepository {

    public init() {}

    public func request<T: Codable>(endpoint: String, path: String, httpMethod: String, resultObject: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {

        let session = URLSession.shared
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = endpoint
        urlComponents.path = path
        let url = urlComponents.url!

        session.dataTask(with: url) { data, response, err in
            if let err = err {
                completion(.failure(err))
            }
            if let data = data {
                do {
                    let decode = JSONDecoder()
                    let value = try decode.decode([T].self, from: data)
                    completion(.success(value[0]))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
