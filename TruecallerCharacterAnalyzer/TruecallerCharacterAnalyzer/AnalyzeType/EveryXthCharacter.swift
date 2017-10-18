//
//  EveryXthCharacter.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation


class EveryXthCharacter: CharacterAnalyzer {
    
    
    func analyze(completionHandler: @escaping (BaseUIModel?, String?) -> Void) {
        print(Constant.Log.InfoPrefix, "Will get every ", Constant.Parameter.CharacterIndex, "th indexed character")
        
        NetworkManager.sharedInstance.request() { (responseType) in
            
                switch responseType{
                case .failure(let error):
                    completionHandler(nil, error.localizedDescription)
                    break
                    
                case .success(let source):
                    let everyXthCharacterModel = EveryXthCharacterUIModel(pageContent: source)
                    
                    if(Constant.Parameter.CharacterIndex >= source.characters.count){
                        print(Constant.Log.ErrorPrefix, "Source of website not have enough character to analiyze!")
                        completionHandler(nil, NSLocalizedString("ContentNotSufficient", comment: ""))
                        
                    }else{
                        
                        //Finds every Xth character within foreach loop in source characters.
                        var charList = [Character]()
                        source.characters.enumerated().forEach { index, str in
                            if (index > 0 && index % Constant.Parameter.CharacterIndex == 0){
                                charList.append(str)
                            }
                        }
                        
                        everyXthCharacterModel.everyXthCharacterList = charList
                        completionHandler(everyXthCharacterModel, nil)
                    }
                    break
                    
                }
            
        }
    }
}
