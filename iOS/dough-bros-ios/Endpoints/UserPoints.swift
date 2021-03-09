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
        
        var request = URLRequest(url: URL(string: endpointURL + "user/createUser")!,timeoutInterval: Double.infinity)
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
    
    static func getUser(email: String) -> [User] {
        print("Getting User!!")
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "user/getUserByEmail/" + email)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        var user = [User]()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            // print(String(data: data, encoding: .utf8)!)
            do {
                user = try JSONDecoder().decode([User].self, from: data)
                print(user)
            } catch let error {
                print(error)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        return user
    }
    
    static func getUserByID(ID: String) -> [User] {
        print("Getting User!!")
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "user/getUserByUID/" + ID)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        var user = [User]()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            // print(String(data: data, encoding: .utf8)!)
            do {
                user = try JSONDecoder().decode([User].self, from: data)
                print(user)
            } catch let error {
                print(error)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        return user
    }
    
    static func findUserByPatternMatching(search: String) -> [User] {
        print("Getting List of Users!!")
        var userList = [User]()
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: endpointURL + "user/findUserByPatternMatching/" + search)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            do {
                userList = try JSONDecoder().decode([User].self, from: data)
                // print(userList)
            } catch let error {
                print(error)
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()

        return userList
    }
}
