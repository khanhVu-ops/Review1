//
//  Extension+String.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/10/22.
//

import Foundation

extension String {
  
    func replaceSpacingToCorrectURLForm() -> String {
        let str = self.replacingOccurrences(of: " ", with: "%20")
        return str
    }
}
