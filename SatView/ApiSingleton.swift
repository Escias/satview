//
//  ApiSingleton.swift
//  SatView
//
//  Created by administration4 on 23/02/2022.
//

import Foundation

public class ApiSingleton {
    
    let url = "https://tle.ivanstanojevic.me/api/tle"
    
    public static let apiSingleton = ApiSingleton()
    
    private init() {
        
    }
    
}
