//
//  Item.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import Foundation
import UIKit

public struct Item {
    public var backgroundColor: UIColor? = .white
    public var selectedBackgroundColor: UIColor? = .clear
    public var image: UIImage?
    public var title: String?
    public var titleColor: UIColor? = .black
    public var font: UIFont? = .systemFont(ofSize: 17)
    
    public init() {}
    public init(title: String?) {
        self.title = title
    }
    public init(image: UIImage?) {
        self.image = image
    }
}

