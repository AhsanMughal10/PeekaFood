//
//  ViewController.swift
//  iOS Project
//
//  Created by Ahsan Mughal on 05/04/2019.
//  Copyright © 2019 Ahsan Mughal. All rights reserved.
//

import UIKit

class ResturantsViewController: UIViewController{
   
    

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
        resturantImages.append(UIImage(named: "hardees-new.jpg")!)
        
      // MARK: Requesting Server
        sendRequestToResturantsAPI()
    }
   
      // MARK: SendRequestToServer
    func sendRequestToResturantsAPI(){
        let jsonUrlString = TaskManager.serverIP + "PeekaFood/getResturants" // Setting API Requests URL

        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        TaskManager.shared.dataTask(withRequest: urlRequest) { (data, response, error) in
            guard let data = data else {return}
            do{
                let responseData = try JSONDecoder().decode([Resturants].self, from: data)

                print(responseData , responseData.count)
                self.resturantsData = responseData
                self.ResturanttabelView.reloadData() // Reloading Data

            }catch let error{
                print("Error decoding",error)
            }
            }
        }
}
  // MARK: TableView Delegate Methods
extension ResturantsViewController : UITableViewDelegate,UITableViewDataSource
{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturantsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resturantcell", for: indexPath) as! ResturantTableViewCell
        cell.ResturantLabel.text = resturantsData[indexPath.row].Name
        cell.resturantImage.image = resturantImages[indexPath.row]
     ResturanttabelView.rowHeight  = resturantImages[indexPath.row].size.height-cell.ResturantLabel.frame.size.height
      
        return cell
    }
     // MARK: Performing Segue from selected Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ItemsMenu", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ItemsViewController
        {
            vc.selectedResturant = resturantsData[(ResturanttabelView.indexPathForSelectedRow?.row) ?? 0] // Passing selected resturant 
            
        }
    }
    
}
