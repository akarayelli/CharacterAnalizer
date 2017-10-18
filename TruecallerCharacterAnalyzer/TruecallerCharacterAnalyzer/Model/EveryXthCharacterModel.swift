//
//  EveryXthCharacterModel.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

class EveryXthCharacterUIModel: BaseUIModel, Presentable{
    
   var everyXthCharacterList: [Character]!
    
    func stringRepresentation() -> String{
        
        let flattenedString = String(
            self.everyXthCharacterList.map{
                String($0)
                }.joined(separator: "\n*******\n")
        )
        
        return flattenedString
    }
}
