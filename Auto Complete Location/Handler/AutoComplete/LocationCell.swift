//
//  LocationCell.swift
//  Auto Complete Location
//
//  Created by TPFLAP146 on 07/05/20.
//  Copyright © 2020 vijay. All rights reserved.
//

import Foundation
import UIKit

//MARK: UI Table View Cell
class LocationCell:UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initialSetup() {
        self.backgroundColor = Constants.ColorTheme.Accent
        self.textLabel?.textAlignment = .center
        self.textLabel?.font = Constants.Fonts.text_m_medium
        self.textLabel?.textColor = Constants.ColorTheme.Dark
        self.detailTextLabel?.font = Constants.Fonts.text_s_regular
        self.detailTextLabel?.textColor = Constants.ColorTheme.Dark
    }
    
}
