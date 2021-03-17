//
//  PaymentPoints.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-12-01.
//

import Foundation

struct PaymentEndpoints {
    
    static func createPayment(payment: PaymentObj) {
        print("Creating Payment!!")
        let encoder = JSONEncoder()
        
        let semaphore = DispatchSemaphore (value: 0)
        
        let jsonData = try? encoder.encode(payment)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/createPayment")!,timeoutInterval: Double.infinity)
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
    
    static func getPayment(parentExpenseID: Int) -> [PaymentObj] {
        print("Getting Payment!!")
        var paymentList = [PaymentObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/" + String(parentExpenseID))!,timeoutInterval: Double.infinity)
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
    
    static func getPaymentsToAndFromUserFromGroup(userID: String, groupID: Int) -> [PaymentObj] {
        print("Getting Payments to and from User from Group!!")
        var paymentList = [PaymentObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/" + String(groupID) + "pending/" + userID)!,timeoutInterval: Double.infinity)
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
    
    static func getPendingPayments(parentExpenseID: Int) -> [PaymentObj] {
        print("Getting Pending Payments!!")
        var paymentList = [PaymentObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/pending/" + String(parentExpenseID))!,timeoutInterval: Double.infinity)
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
    
    static func getPaidPayments(parentExpenseID: Int) -> [PaymentObj] {
        print("Getting Paid Payments!!")
        var paymentList = [PaymentObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/paid/" + String(parentExpenseID))!,timeoutInterval: Double.infinity)
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
    
    static func getSettledPayments(parentExpenseID: Int) -> [PaymentObj] {
        print("Getting Settled Payments!!")
        var paymentList = [PaymentObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/settled/" + String(parentExpenseID))!,timeoutInterval: Double.infinity)
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
    
    static func getPaymentsToUserFromGroup(userID: String, groupID: Int) -> [PaymentObj] {
        print("Getting Payments to User from Group!!")
        var paymentList = [PaymentObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/" + String(groupID) + "/received/" + userID)!,timeoutInterval: Double.infinity)
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
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/" + String(groupID) + "/settled/" + userID)!,timeoutInterval: Double.infinity)
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
    
    static func getSentPaymentsFromUserFromGroup(senderID: String, groupID: Int) -> [PaymentObj] {
        print("Getting Sent Payments from Sender!!")
        var paymentList = [PaymentObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/" + String(groupID) + "/sent/" + senderID)!,timeoutInterval: Double.infinity)
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
    
    static func payPayment(paymentID: Int) {
        print("Paying Payment!!")
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: endpointURL + "payment/payPayment/" + String(paymentID))!,timeoutInterval: Double.infinity)
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
    
    static func settlePayment(paymentID: Int) {
        print("Settling Payment!!")
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: endpointURL + "payment/settlePayment/" + String(paymentID))!,timeoutInterval: Double.infinity)
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

/// Endpoints using PaymentBothNamesObj instead of PaymentObj
extension PaymentEndpoints {
    static func getGroupSettledPayments(groupID: Int) -> [PaymentBothNamesObj] {
        print("Getting Group Pending Payments!!")
        var paymentList = [PaymentBothNamesObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/settled/group/" + String(groupID))!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            // print(String(data: data, encoding: .utf8)!)
            do {
                paymentList = try JSONDecoder().decode([PaymentBothNamesObj].self, from: data)
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
    
    static func getGroupPendingPayments(groupID: Int) -> [PaymentBothNamesObj] {
        print("Getting Group Pending Payments!!")
        var paymentList = [PaymentBothNamesObj]()
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: endpointURL + "payment/pending/group/" + String(groupID))!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            // print(String(data: data, encoding: .utf8)!)
            do {
                paymentList = try JSONDecoder().decode([PaymentBothNamesObj].self, from: data)
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
