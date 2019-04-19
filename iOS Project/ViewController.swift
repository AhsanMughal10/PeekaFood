//
//  ViewController.swift
//  iOS Project
//
//  Created by Ahsan Mughal on 05/04/2019.
//  Copyright © 2019 Ahsan Mughal. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
   
    

    @IBOutlet weak var ResturanttabelView: UITableView!
    var resturantsData = [Resturants]()
    var resturantImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
          // MARK: Setting delegates of TableView
        ResturanttabelView.delegate = self
        ResturanttabelView.dataSource = self
     // MARK: Making array for Images
        resturantImages.append(UIImage(named: "pizzahut.jpg")!)
        resturantImages.append(UIImage(named: "jessies.jpg")!)
        resturantImages.append(UIImage(named: "howdy.jpg")!)
        
      // MARK: Requesting Server
      sendRequestToServer()
        
        
    }
   
      // MARK: SendRequestToServer
    func sendRequestToServer(){
        let jsonUrlString = TaskManager.serverIP + "TestService/Hi"
        
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let body = try JSONEncoder().encode("")
            urlRequest.httpBody = body
        } catch  {}
        TaskManager.shared.dataTask(withRequest: urlRequest) { (data, response, error) in
            guard let data = data else {return}
            do{
                let responseData = try JSONDecoder().decode([Resturants].self, from: data)
                
                print(responseData , responseData.count)
                self.resturantsData = responseData
                self.ResturanttabelView.reloadData()
                
            }catch let error{
                print("Error decoding",error)
            }
            
            
        }
        
        
    }
}
  // MARK: TableView Delegate Methods
extension ViewController : UITableViewDelegate,UITableViewDataSource
{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturantsData.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resturantcell", for: indexPath) as! ResturantTableViewCell
        cell.ResturantLabel.text = resturantsData[indexPath.row].Name
        cell.resturantImage.image = resturantImages[indexPath.row]
        ResturanttabelView.rowHeight  = resturantImages[indexPath.row].size.height-cell.ResturantLabel.frame.size.height
       
        return cell
    }
    
}
