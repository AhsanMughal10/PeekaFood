//
//  ItemsViewController.swift
//  iOS Project
//
//  Created by Ahsan Mughal on 27/04/2019.
//  Copyright © 2019 Ahsan Mughal. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController{
 
    
    @IBOutlet weak var ItemsCollectionView: UICollectionView!
    var ItemsArray = [Items]()
    var selectedResturant = Resturants()
    var itemsImages = [CustomItemImages]()
    var allImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
         // MARK: Setting delegates of CollectionView
        ItemsCollectionView.delegate = self
        ItemsCollectionView.dataSource = self
      
        navigationItem.title = selectedResturant.Name + " Menu" //Setiing navigationItem Title
        sendRequestToItemsAPI()   // Sending request to API to get Items data
         getAllItemsImages()      // Fetching Items Images
        
        
    }
   
    
    func sendRequestToItemsAPI(){
        let jsonUrlString = TaskManager.serverIP + "PeekaFood/getItems" // Setting API Requests URL
        
        guard let url = URL(string: jsonUrlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        TaskManager.shared.dataTask(withRequest: urlRequest) { (data, response, error) in
            guard let data = data else {return}
            do{
                let ItemsData = try JSONDecoder().decode([Items].self, from: data)
                
               print(ItemsData , ItemsData.count)
               self.ItemsArray = ItemsData // Setting Inner response to our model array
               self.ItemsArray = self.ItemsArray.filter{ $0.resturantID == self.selectedResturant.id } // Filtering releveant Items
                self.itemsImages = self.itemsImages.filter{$0.itemImageName.contains(String(self.selectedResturant.id))} // Filtering relevant Images
                
           
               self.ItemsCollectionView.reloadData() // Reloading CollectionView Cells
                
            }catch let error{
                print("Error decoding",error)
            }
        }
    }
    func getAllItemsImages(){
        // Setting Images to a UIImage array
        allImages.append(UIImage(named: "1_chickentikka-supreme.png")!)
        allImages.append(UIImage(named: "1_chickenfajita.png")!)
        allImages.append(UIImage(named: "1_spicy_ranch.png")!)
        allImages.append(UIImage(named: "1_supper_sicilian.png")!)
        allImages.append(UIImage(named: "1_bbq_buzz.png")!)
        allImages.append(UIImage(named: "2_kahuna.jpg")!)
        allImages.append(UIImage(named: "2_mushroom.jpg")!)
        allImages.append(UIImage(named: "3_volconda.jpg")!)
        allImages.append(UIImage(named: "3_shroomin.jpg")!)
        allImages.append(UIImage(named: "3_wrangler.jpg")!)
        allImages.append(UIImage(named: "3_sunofabun.jpg")!)
        allImages.append(UIImage(named: "3_rodeoglory.jpg")!)
        allImages.append(UIImage(named: "6_jalapenoburger.jpg")!)
        allImages.append(UIImage(named: "6_agnus.jpeg")!)
        allImages.append(UIImage(named: "6_original.jpeg")!)
        
        // Setting Images to custom Image class
        
        itemsImages.append(CustomItemImages(imageName: "1_chickentikka-supreme.png",image:allImages[0]))
        itemsImages.append(CustomItemImages(imageName: "1_chickenfajita.png",image:allImages[1]))
        itemsImages.append(CustomItemImages(imageName: "1_spicy_ranch.png",image:allImages[2]))
        itemsImages.append(CustomItemImages(imageName: "1_supper_sicilian.png",image:allImages[3]))
        itemsImages.append(CustomItemImages(imageName: "1_bbq_buzz.png",image:allImages[4]))
        itemsImages.append(CustomItemImages(imageName: "2_kahuna.jpg",image:allImages[5]))
        itemsImages.append(CustomItemImages(imageName: "2_mushroom.jpg",image:allImages[6]))
        
        itemsImages.append(CustomItemImages(imageName: "3_volconda.jpg",image:allImages[7]))
        itemsImages.append(CustomItemImages(imageName: "3_shroomin.jpg",image:allImages[8]))
        itemsImages.append(CustomItemImages(imageName: "3_wrangler.jpg",image:allImages[9]))
        itemsImages.append(CustomItemImages(imageName: "3_sunofabun.jpg",image:allImages[10]))
        itemsImages.append(CustomItemImages(imageName: "3_rodeoglory.jpg",image:allImages[11]))
        
        itemsImages.append(CustomItemImages(imageName: "6_jalapenoburger.jpg",image:allImages[12]))
        itemsImages.append(CustomItemImages(imageName: "6_agnus.jpeg",image:allImages[13]))
        itemsImages.append(CustomItemImages(imageName: "6_original.jpeg",image:allImages[14]))
        
        
    }
   

}
 // MARK: UICollectionView  Delegate Methods
extension ItemsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        cell.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        cell.itemImageView.image = itemsImages[indexPath.row].itemImage
        cell.itemInfoLabel.text = ItemsArray[indexPath.row].itemName
        cell.itemInfoLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       
        cell.itemPriceLabel.layer.masksToBounds = true
       
        cell.itemPriceLabel.layer.cornerRadius = 10.0
        cell.itemPriceLabel.text = "Rs. " + String(ItemsArray[indexPath.row].itemPrice)
        return cell
        
    }
    // Setting Item cell height and width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width , height: 175)
    }
    
}
