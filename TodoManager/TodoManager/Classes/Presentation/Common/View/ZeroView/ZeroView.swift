//
//  ZeroView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 15/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

class ZeroView: UIView, ViewModelConfigurable {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var infoLabel: UILabel! {
        willSet { newValue.textColor = .tdTextGrey } 
    }
    
    func configure(for viewModel: ZeroViewModel) {
        infoLabel.text = viewModel.info
    }

}
