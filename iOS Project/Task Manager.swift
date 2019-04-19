//
//  Task Manager.swift
//  iOS Project
//
//  Created by Ahsan Mughal on 06/04/2019.
//  Copyright © 2019 Ahsan Mughal. All rights reserved.
//

import Foundation

class TaskManager {
    static let shared = TaskManager()
    static let serverIP = "http://192.168.1.107:8080/rest/"
 
    let session = URLSession.shared
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(withRequest url: URLRequest, completion: @escaping completionHandler) {
        let _ = session.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                print("Finished network task")
                completion(data,response,error)
            }
          
        }).resume()
    }
}
