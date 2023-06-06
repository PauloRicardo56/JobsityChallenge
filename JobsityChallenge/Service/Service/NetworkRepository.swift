//
//  NetworkRepository.swift
//  Service
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

public protocol NetworkRepository {

    func request<T: Codable>(
        endpoint: String,
        path: String,
        resultObject: T.Type,
        completion: @escaping (Result<T?, Error>) -> Void
    )

    func request(
        url: String,
        completion: @escaping (Result<Data, Error>) -> Void
    )
}
