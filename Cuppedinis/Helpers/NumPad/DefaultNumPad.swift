//
//  DefaultNumPad.swift
//  NumPad
//
//  Created by Lasha Efremidze on 1/7/18.
//  Copyright © 2018 Lasha Efremidze. All rights reserved.
//

import UIKit

open class DefaultNumPad: NumPad {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        dataSource = self
    }
    
}

extension DefaultNumPad: NumPadDataSource {
    
    public func numberOfRowsInNumPad(_ numPad: NumPad) -> Int {
        return 4
    }
    
    public func numPad(_ numPad: NumPad, numberOfColumnsInRow row: Row) -> Int {
        return 3
    }
    
    public func numPad(_ numPad: NumPad, itemAtPosition position: Position) -> Item {
        var item = Item()
        item.title = {
            switch position {
            case (3, 0):
                return "00"
            case (3, 1):
                return "0"
            case (3, 2):
                return "Limpiar"
            default:
                var index = (0..<position.row).map { self.numPad(self, numberOfColumnsInRow: $0) }.reduce(0, +)
                index += position.column
                return "\(index + 1)"
            }
        }()
        item.titleColor = {
            switch position {
            case (3, 2):
                return UIColor.darkGray
            default:
                return .white
            }
        }()
        
        item.backgroundColor = UIColor.clear
        
        item.font = {
            switch position {
            case (3, 2):
                return .systemFont(ofSize: 22)
            default:
                return .systemFont(ofSize: 40)
            }
        }()
        return item
    }
    
}
