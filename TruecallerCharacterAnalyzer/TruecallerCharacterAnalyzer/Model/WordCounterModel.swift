//
//  WordCounterModel.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

class WordCounterUIModel: BaseUIModel, Presentable{
    
    var wordList: [String:Int]!
    
    func stringRepresentation() -> String {
        
        let flattenedString = self.wordList.map {
            $0 + ":" + String($1)
            }.joined(separator: "\n*******\n")
        
        return flattenedString
    }
}


