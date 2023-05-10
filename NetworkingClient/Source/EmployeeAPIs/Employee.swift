//
//  File.swift
//  NetworkingClient
//
//  Created by Raviraj Wadhwa on 09/05/23.
//

import Foundation

// MARK: - Employee

struct Employee: Codable {
    let name: String?
    let salary: Double?
    let age: Int?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case salary = "salary"
        case age = "age"
        case id = "id"
    }
}
