//
//  Operations.swift
//  GrandPlayGround
//
//  Created by Hossam on 7/27/19.
//  Copyright © 2019 Hossam. All rights reserved.
//



import Foundation
import UIKit


class Image {
    enum Status {
        case cancelled
        case completed
    }
    let url = URL(string: "https://images.unsplash.com/photo-1484583066749-c2129489f52f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80")!
    var status : Status = .cancelled
    var indexPath = IndexPath()
    var data : Data?
}

class DownloadImageManager  : Operation{
    let image : Image
    init(image : Image) {
        self.image = image
        super.init()
    }
    var _isAsynchronous = false
    override var isAsynchronous: Bool {
        
        get{
            return _isAsynchronous
        }
        set{
            willChangeValue(forKey: "isAsynchronous")
            _isAsynchronous = newValue
            didChangeValue(forKey: "isAsynchronous")
        }
    }
    var _isExecuting = false
    override var isExecuting: Bool{
        get{
            return _isExecuting
        }
        set{
            willChangeValue(forKey: "isExecuting")
            _isExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    var _isFinished = false
    override var isFinished: Bool {
        get{
            return _isFinished
        }
        set{
            willChangeValue(forKey: "isFinished")
            _isFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override func main()  {
        if isCancelled {
            return
            }
       
        if self.isCancelled {
            return
            }
        
        if  self.image.data == nil {
           
        self.image.data = try! Data(contentsOf: image.url)
        self.image.status = .completed
            
        }
    
        isFinished = true
        isExecuting = false
    }
}
