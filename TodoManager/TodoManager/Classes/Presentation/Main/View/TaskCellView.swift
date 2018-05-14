//
//  TaskCellView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class TaskCellView: UIView, ViewModelConfigurable {
    
    // MARK: - IBOutlets
    
    @IBOutlet var contentView: UIView! {
        willSet {
            newValue.backgroundColor = .tdElement
            newValue.layer.masksToBounds = true
            newValue.layer.cornerRadius = 16
        }
    }
    @IBOutlet var headerView: UIView! {
        willSet {
            newValue.backgroundColor = .tdHeader
        }
    }
    @IBOutlet var dateLabel: UILabel! {
        willSet {
            newValue.textColor = .tdText
        }
    }
    @IBOutlet var titleLabel: UILabel! {
        willSet {
            newValue.textColor = .tdText
        }
    }
    @IBOutlet var descriptionLabel: UILabel! {
        willSet {
            newValue.textColor = .tdText
        }
    }
    @IBOutlet var checkBox: CircleCheckBoxView!
    
    
    // MARK: - View LyfeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    
    // MARK: - ViewModelConfigurable
    
    func configure(for viewModel: TaskViewModel) {
        dateLabel.text = viewModel.creationDateFromatted
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        checkBox.isChecked = viewModel.completed
    }
    
    func clear() {
        dateLabel.text = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
}
