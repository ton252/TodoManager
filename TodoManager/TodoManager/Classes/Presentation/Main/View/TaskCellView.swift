//
//  TaskCellView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class TaskCellView: UIView, ViewModelConfigurable {
    
    @IBOutlet var contentView: UIView! {
        willSet {
            newValue.layer.masksToBounds = true
            newValue.layer.cornerRadius = 16
        }
    }
    @IBOutlet var headerView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    // MARK: - ViewModelConfigurable
    
    func configure(for viewModel: TaskViewModel) {
        dateLabel.text = viewModel.creationDateFromatted
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
    func clear() {
        dateLabel.text = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    
}
