//
//  NetworkingClientApp.swift
//  NetworkingClient
//
//  Created by Raviraj Wadhwa on 05/05/23.
//

import SwiftUI

@main
struct NetworkingClientApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    creatingExampleRequests()
                }
        }
    }

    private func creatingExampleRequests() {
        do {
            let request1 = try EmployeeRequests.getAllEmployees.create()
            // Request created
            // Make a call
        } catch {
            // Error in request creation
        }

        if let request2 = try? EmployeeRequests.getEmployee(1).create() {
            // Request created
            // Make a call
        } else {
            // Error in request creation
        }

        let request3 = try? EmployeeRequests.deleteEmployee(1).create()

        let request4 = try? EmployeeRequests.searchEmployees("test", 1000, nil).create()

        let employee = Employee(
            name: "test",
            salary: 123456,
            age: 18,
            id: nil
        )

        let request5 = try? EmployeeRequests.createEmployee(employee).create()

        let request6 = try? EmployeeRequests.updateEmployee(1, employee).create()
    }
}
