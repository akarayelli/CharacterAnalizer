//
//  XthCharacterModel.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

class XthCharacterUIModel: BaseUIModel, Presentable{
    
    var xthCharacter: Character!
    
    func stringRepresentation() -> String {
        return self.xthCharacter.description
    }
}
