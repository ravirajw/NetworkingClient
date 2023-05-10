//
//  URLRequestCreator.swift
//  NetworkingClient
//
//  Created by Raviraj Wadhwa on 09/05/23.
//

import Foundation

protocol URLRequestCreator {

    associatedtype BodyObject: Encodable

    var baseUrlString: String { get }
    var apiPath: String? { get }
    var apiVersion: HTTPRequestAPIVersion? { get }
    var endPoint: String? { get }
    var queryString: String? { get }
    var queryItems: [URLQueryItem]? { get }
    var method: HTTPRequestMethod { get }
    var headers: [String: String]? { get }
    var bodyParameters: [String: Any]? { get }
    var bodyObject: BodyObject? { get }

}

extension URLRequestCreator {

    func create() throws -> URLRequest {

        guard var urlComponents = URLComponents(string: baseUrlString) else {
            throw URLRequestCreatorError.failedToCreateURLComponents
        }

        var fullPath = ""

        if let apiPath {
            fullPath += "/" + apiPath
        }

        if let apiVersion {
            fullPath += "/" + apiVersion.rawValue
        }

        if let endPoint {
            fullPath += "/" + endPoint
        }

        if let queryString {
            fullPath += "/" + queryString
        }

        urlComponents.path = fullPath

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            throw URLRequestCreatorError.failedToGetURLFromURLComponents
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        let jsonData = try? JSONEncoder().encode(bodyObject)
        request.httpBody = jsonData

        return request

    }

}

enum URLRequestCreatorError: Error {
    case failedToCreateURLComponents
    case failedToGetURLFromURLComponents
}

/// Here we are passing default / similar values that most apis in app will have
/// However in some case different module may have different base URL then that different base URL can be provided from that module.
extension URLRequestCreator  {
    var baseUrlString: String {
        "https://dummy.restapiexample.com"
    }
}
