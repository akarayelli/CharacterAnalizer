//
//  WordCounter.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

class WordCounter: CharacterAnalyzer {
    
    func analyze(completionHandler: @escaping (BaseModel?, String?) -> Void) {
        print(Constant.Log.WarningPrefix, "Will count all words")
        
        NetworkManager.sharedInstance.request { (responseType) in
            
            switch responseType{
            case .failure(let error):
                completionHandler(nil, error.localizedDescription)
                break
                
            case .success(let source):
                let wordCounterModel = WordCounterModel()
                wordCounterModel.pageContent = source
                
                let words = source.components(separatedBy: .whitespaces)
                var wordDictionary = [String:Int]()
                for word in words {
                    if let count = wordDictionary[word] {
                        wordDictionary[word] = count + 1
                    } else {
                        wordDictionary[word] = 1
                    }
                }
                
                wordCounterModel.wordList = wordDictionary
                completionHandler(wordCounterModel,nil)
                break
            }
        }
    }
}

