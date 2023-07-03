//
//  Resource.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 03/07/23.
//

import Foundation

class Resource<T> {
    
    var result: T?
    var errorCode: Int? = nil
    
    init(result: T? = nil, errorCode: Int? = nil) {
        self.result = result
        self.errorCode = errorCode
    }
   
}
