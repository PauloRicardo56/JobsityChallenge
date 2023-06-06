//
//  NetworkRepository.swift
//  Service
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

protocol NetworkRepository {
    func request<T: Codable>(endpoint: String, path: String, httpMethod: String, resultObject: T.Type, completion: @escaping (Result<T?, Error>) -> Void)
}
