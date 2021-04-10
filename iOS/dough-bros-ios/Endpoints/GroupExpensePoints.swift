//
//  GroupExpensePoints.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2021-01-29.
//

import Foundation

struct GroupExpenseEndpoints {
    static func createGroupExpense(groupExpense: GroupExpenseObj) -> Int  {
        print("Creating Group Expense!!")
        let encoder = JSONEncoder()
        
        let semaphore = DispatchSemaphore (value: 0)
        
        let jsonData = try? encoder.encode(groupExpense)
        
        var request = URLRequest(url: URL(string: endpointURL + "group_expense/createGroupExpense")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        var groupExpenseID = 0
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
             print(String(data: data, encoding: .utf8)!)
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:data, options: [])
                let jsonArray = jsonResponse as? [String: Any]
                groupExpenseID = jsonArray!["expense_id"] as? Int ?? 0
                // print(groupID)
            } catch let parsingError {
                print("Error", parsingError)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return groupExpenseID
    }
    
    static func getGroupExpenses(groupID: String) -> [GroupExpenseObj] {
        print("Getting Group Expenses!!")
        var groupList = [GroupExpenseObj]()
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: endpointURL + "group_expense/getGroupExpenseByGroupId/" + groupID)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          // print(String(data: data, encoding: .utf8)!)
            do {
                groupList = try JSONDecoder().decode([GroupExpenseObj].self, from: data)
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
    
    static func getParentGroupExpenseByPaymentId(paymentId: String) -> [ParentGroupExpenseObj] {
        print("Getting Parent Group Expense!!")
        var groupList = [ParentGroupExpenseObj]()
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: endpointURL + "group_expense/getGroupExpenseByPaymentId/" + paymentId)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          // print(String(data: data, encoding: .utf8)!)
            do {
                groupList = try JSONDecoder().decode([ParentGroupExpenseObj].self, from: data)
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
}

