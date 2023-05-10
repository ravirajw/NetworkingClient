//
//  NetworkSession.swift
//  NetworkingClient
//
//  Created by Raviraj Wadhwa on 05/05/23.
//

import Foundation
import Combine

protocol HTTPClient {

    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>

}

extension URLSession: HTTPClient {

    struct InvalidHTTPURLResponseError: Error {}

    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpUrlResponse = result.response as? HTTPURLResponse else {
                    throw InvalidHTTPURLResponseError()
                }
                return (result.data, httpUrlResponse)
            }
            .eraseToAnyPublisher()
    }

}
