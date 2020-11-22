//
//  GroupPoints.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-21.
//

import Foundation

struct GroupEndpoints {
    static func createGroup(group: GroupObj) -> Int  {
        print("Creating Group!!")
        let encoder = JSONEncoder()
        
        let semaphore = DispatchSemaphore (value: 0)
        
        let jsonData = try? encoder.encode(group)
        
        var request = URLRequest(url: URL(string: "http://localhost:8000/groups/createGroup")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        var groupID = 0
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            // print(String(data: data, encoding: .utf8)!)
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:data, options: [])
                let jsonArray = jsonResponse as? [String: Any]
                groupID = jsonArray!["id"] as? Int ?? 0
                // print(groupID)
            } catch let parsingError {
                print("Error", parsingError)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return groupID
    }
    
    static func addUserToGroup(user: User, groupID: Int, addedBy: String) {
        print("Adding User To Group!!")
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\n    \"group_id\": \"" + String(groupID) + "\",\n    \"user_id\": \"" + user.firebase_uid + "\",\n    \"addedBy\": \"" + addedBy + "\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://localhost:8000/groups/addUserToGroup")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
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

