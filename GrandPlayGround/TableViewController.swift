//
//  TableViewController.swift
//  GrandPlayGround
//
//  Created by Hossam on 7/6/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit



class TableViewController: UITableViewController , UITableViewDataSourcePrefetching {
    
    
  
    let opertaionsQueue = OperationQueue()
    var downloadingData : [IndexPath : Image] = [:]
    var downloadedData : [IndexPath : Image] = [:]
    
    func startDownDataWith(indexPaths : [IndexPath]){
        print("HereX")
        for index in indexPaths {
            if  downloadedData[index] != nil  || downloadingData[index] != nil{
                
            }
            else {
                let image = Image()
                image.indexPath = index
                let opertaion = DownloadImageManager(image: image)
                opertaion.name = "\(index)"
                opertaion.queuePriority = .veryHigh
                opertaionsQueue.addOperation(opertaion)
                downloadingData.updateValue(image, forKey: index)
                
                
                opertaion.completionBlock = {
                    self.downloadingData.removeValue(forKey: index)
                    self.downloadedData.updateValue(image, forKey: index)
                    DispatchQueue.main.async {
                         self.tableView.reloadData()
                        if self.tableView.indexPathsForVisibleRows!.contains(index){
                           
                        }
                  
                        
                        }
                        
                    }
                

                
            }
            
        }
        
}
    
    func startFirstCells(){
        
        let indexPath = tableView.indexPathsForVisibleRows!
         startDownDataWith(indexPaths: indexPath)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexx = [IndexPath(item: 0, section: 0) , IndexPath(item: 1, section: 0) , IndexPath(item: 2, section: 0) , IndexPath(item: 3, section: 0)]
      startDownDataWith(indexPaths:  indexx)
    }

    
    @IBAction func GranBiAction(_ sender: UIButton) {
       
        if  self.tableView.isEditing {
            self.tableView.setEditing(false, animated: true)
            
        } else {
           
            self.tableView.setEditing(true, animated: true)
        
        }
        
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.estimatedRowHeight = 350
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
    }
    

    

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.downloadedData.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "T", for: indexPath) as! TCellView
//        if let data = downloadedData[indexPath]?.data {
//            let image = UIImage(data: data)
//            cell.imageViewDAta.image = image
//        }
       
        return cell
    }
   
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Here")
        let newIndex = IndexPath(item: indexPath.row + 1, section: indexPath.section + 1)
        self.downloadedData.updateValue(Image(), forKey: newIndex)
        self.tableView.insertRows(at: [newIndex], with: .none)
       
    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
       print("PREFETCH")
        startDownDataWith(indexPaths: indexPaths)
    }
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
       opertaionToGetLow(with: indexPaths)
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        opertaionToGetLow(with: [indexPath])
    }
    
    func opertaionToGetLow(with indexPaths : [IndexPath]){
        for index in indexPaths{
            let opertaionToCancel = self.opertaionsQueue.operations.filter{$0.name == "\(index)"}
            opertaionToCancel.forEach{
                $0.queuePriority = .veryLow
            }
        }
    }
    
    
}

    

