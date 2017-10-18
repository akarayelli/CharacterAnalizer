//
//  BaseModel.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation


protocol Presentable{
    func stringRepresentation() -> String
}

class BaseUIModel {
    
    var pageContent: String!
    
    init(pageContent: String) {
       self.pageContent = pageContent
    }
}
