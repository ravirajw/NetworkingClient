//
//  EmployeeRequests.swift
//  NetworkingClient
//
//  Created by Raviraj Wadhwa on 09/05/23.
//

import Foundation

typealias EmployeeId = Int
typealias EmployeeName = String
typealias EmployeeSalary = Double
typealias EmployeeAge = Int

enum EmployeeRequests {
    case getAllEmployees
    case getEmployee(EmployeeId)
    case createEmployee(Employee)
    case updateEmployee(EmployeeId, Employee)
    case deleteEmployee(EmployeeId)
    case searchEmployees(EmployeeName?, EmployeeSalary?, EmployeeAge?)
}

extension EmployeeRequests: URLRequestCreator {
    typealias BodyObject = Employee

    var apiPath: String? {
        "api"
    }

    var apiVersion: HTTPRequestAPIVersion? {
        .v1
    }

    var endPoint: String? {
        switch self {
        case .getAllEmployees:
            return "employees"
        case .getEmployee:
            return "employee"
        case .createEmployee:
            return "create"
        case .updateEmployee:
            return "update"
        case .deleteEmployee:
            return "delete"
        case .searchEmployees:
            return "search"
        }
    }

    var queryString: String? {
        switch self {
        case .getEmployee(let employeeId), .updateEmployee(let employeeId, _), .deleteEmployee(let employeeId):
            return String(employeeId)
        default:
            return nil
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchEmployees(let employeeName, let employeeSalary, let employeeAge):
            var queryItems = [URLQueryItem]()
            if let employeeName {
                queryItems.append(URLQueryItem(name: "name", value: employeeName))
            }
            if let employeeSalary {
                queryItems.append(URLQueryItem(name: "salary", value: String(employeeSalary)))
            }
            if let employeeAge {
                queryItems.append(URLQueryItem(name: "age", value: String(employeeAge)))
            }
            return queryItems
        default:
            return nil
        }
    }

    var method: HTTPRequestMethod {
        switch self {
        case .getAllEmployees:
            return .GET
        case .getEmployee:
            return .GET
        case .createEmployee:
            return .POST
        case .updateEmployee:
            return .PUT
        case .deleteEmployee:
            return .DELETE
        case .searchEmployees:
            return .GET
        }
    }

    var headers: [String: String]? {
        switch self {
        case .createEmployee, .updateEmployee:
            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }

    var bodyParameters: [String : Any]? {
        return nil
    }

    var bodyObject: Employee? {
        switch self {
        case .createEmployee(let employee), .updateEmployee(_, let employee):
            return employee
        default:
            return nil
        }
    }
}
