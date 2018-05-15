//
//  TaskCellView.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit

final class TaskCell: ListCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView! {
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
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let alpha: CGFloat = highlighted ? 0.5 : 1
        if animated {
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.alpha = alpha
            }
        } else {
            self.alpha = alpha
        }
    }
    
    
    // MARK: - View LyfeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    
    // MARK: - ViewModelConfigurable
    
    override func configure(for viewModel: ViewModel) {
        guard let viewModel = viewModel as? TaskViewModel else { return }
        dateLabel.text = viewModel.creationDateFromatted
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        checkBox.isChecked = viewModel.completed
    }
    
    override func clear() {
        dateLabel.text = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
}
