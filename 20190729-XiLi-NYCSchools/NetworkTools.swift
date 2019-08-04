//
//  NetworkTools.swift
//  20190729-XiLi-NYCSchools
//
//  Created by Lucas on 7/29/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation

class NetworkTools :NSObject{
    static let shared: NetworkTools  =
    {
        let tools = NetworkTools()
        
        return tools
        
    }()
    
    

    func request(url: String, finished: @escaping ([String]?,Error?) -> ()) {

        let schoolAPI = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        let session = URLSession(configuration: .default)
        let urlAdd = URLRequest(url: URL(string: schoolAPI)!)

        session.dataTask(with: urlAdd) { (data:Data?, res:URLResponse?,error:Error?) in
            if error == nil{
                let dataAarray:NSMutableArray = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSMutableArray
                var data: [String] = [String]()
                for item in dataAarray
                {
                    let model = Model()
                    model.setValuesForKeys(item as! [String : Any])
                    data.append(model.school_name! + "\n" + model.dbn!)
                    
                }
                data.sort(){
                    $0 < $1

                }
                finished(data,nil)
            }
        }.resume()
}
    
    

    func delateRequest(finished: @escaping (NSMutableDictionary?,Error?) -> ()) {
        
        let schoolAPI = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
        let session = URLSession(configuration: .default)
        let urlAdd = URLRequest(url: URL(string: schoolAPI)!)
        
        session.dataTask(with: urlAdd) { (data:Data?, res:URLResponse?,error:Error?) in
            if error == nil{
                let dataAarray:NSMutableArray = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSMutableArray
                let data = NSMutableDictionary()
                for item in dataAarray
                {
                    let model = Model()
                    model.setValuesForKeys(item as! [String : Any])

                    data.setValue(model, forKey: model.dbn!)
                    
                }
                finished(data,nil)
            }
            }.resume()
    }






}
    
    
    
    
    
    
    
    
    

