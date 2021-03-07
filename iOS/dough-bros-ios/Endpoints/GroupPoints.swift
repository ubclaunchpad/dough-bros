//
//  GroupPoints.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-21.
//

import Foundation

//public var endpointURL = "http://localhost:8000/"
public var endpointURL = "http://ec2-34-214-245-195.us-west-2.compute.amazonaws.com:8000/"

struct GroupEndpoints {
    
    static func createGroup(group: GroupObj) -> Int  {
        print("Creating Group!!")
        let encoder = JSONEncoder()
        
        let semaphore = DispatchSemaphore (value: 0)
        
        let jsonData = try? encoder.encode(group)
        
        var request = URLRequest(url: URL(string: endpointURL + "group/createGroup")!,timeoutInterval: Double.infinity)
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
        
        let parameters = "{\n    \"group_id\": \"" + String(groupID) + "\",\n    \"user_id\": \"" + user.firebase_uid + "\",\n    \"added_by_id\": \"" + addedBy + "\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: endpointURL + "group/addUserToGroup")!,timeoutInterval: Double.infinity)
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
    
    static func getGroups(userID: String) -> [GroupObj] {
        print("Getting Users Groups!!")
        var groupList = [GroupObj]()
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: endpointURL + "group/getGroupByUID/" + userID)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          // print(String(data: data, encoding: .utf8)!)
            do {
                groupList = try JSONDecoder().decode([GroupObj].self, from: data)
                // print(groupList)
            } catch let error {
                print(error)
            }
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
        return groupList
    }
    
    static func getPendingGroups(userID: String) -> [GroupObj] {
        print("Getting Users Pending Groups!!")
        var groupList = [GroupObj]()
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: endpointURL + "group/getPendingGroupByUID/" + userID)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          // print(String(data: data, encoding: .utf8)!)
            do {
                groupList = try JSONDecoder().decode([GroupObj].self, from: data)
                // print(groupList)
            } catch let error {
                print(error)
            }
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
        return groupList
    }
    
    static func getUsersInGroup(groupID: Int) -> [User] {
        print("Getting Users!!")
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "group/getAllGroupUsers/" + String(groupID))!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        var user = [User]()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
//            print(String(data: data, encoding: .utf8)!)
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
    
    static func acceptGroupMembership(groupID: Int, userID: String) {
        print("Accepting Membership!!")
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: endpointURL + "group/acceptGroupMembership/" + String(groupID) + "/" + userID)!,timeoutInterval: Double.infinity)
        request.httpMethod = "PUT"

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

    static func setGroupName(groupID: Int, groupName: String) {
        print("Setting Group Name!!")
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: endpointURL + "group/setGroupName/" + String(groupID) + "/" + groupName)!,timeoutInterval: Double.infinity)
        request.httpMethod = "PUT"

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

