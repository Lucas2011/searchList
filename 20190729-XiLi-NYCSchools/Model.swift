//
//  Model.swift
//  20190729-XiLi-NYCSchools
//
//  Created by Lucas on 7/29/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit

class Model: NSObject {
    @objc var dbn:String?
    @objc var school_name:String?
    @objc var sat_writing_avg_score:String?
    @objc var sat_critical_reading_avg_score:String?
    @objc var sat_math_avg_score:String?
    @objc var website:String?
    
    
    

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}



