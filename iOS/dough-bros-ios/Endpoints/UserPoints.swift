//
//  User.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-10.
//

import Foundation

struct UserEndpoints {
    static func createUser(user: User) {
        print("Creating User!!")
        let encoder = JSONEncoder()

        let semaphore = DispatchSemaphore (value: 0)

        let jsonData = try? encoder.encode(user)

        var request = URLRequest(url: URL(string: "http://localhost:8000/users/createUser")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}
