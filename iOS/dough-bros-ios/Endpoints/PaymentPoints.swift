//
//  PaymentPoints.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-12-01.
//

import Foundation

struct PaymentEndpoints {
    static func getPaymentsToUserFromGroup(userID: String, groupID: Int) -> [PaymentObj] {
        print("Getting Payments to User from Group!!")
        var paymentList = [PaymentObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: "http://localhost:8000/payments/" + String(1) + "/received/" + userID)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            // print(String(data: data, encoding: .utf8)!)
            do {
                paymentList = try JSONDecoder().decode([PaymentObj].self, from: data)
                // print(groupList)
            } catch let error {
                print(error)
            }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
        return paymentList
    }
    
    static func getSettledPaymentsToUserFromGroup(userID: String, groupID: Int) -> [PaymentObj] {
        print("Getting Settled Payments to User from Group!!")
        var paymentList = [PaymentObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: "http://localhost:8000/payments/" + String(1) + "/settled/" + userID)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            // print(String(data: data, encoding: .utf8)!)
            do {
                paymentList = try JSONDecoder().decode([PaymentObj].self, from: data)
                // print(groupList)
            } catch let error {
                print(error)
            }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
        return paymentList
    }
}
