//
//  ContainerCell.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import UIKit


class ContainerCell<T: ViewModelConfigurable>: ListCell where T: UIView {
    
    let infoView = T.loadFromNib() ?? T(frame: .zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoView)
        infoView.fillSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(for viewModel: ViewModel) {
        guard let viewModel = viewModel as? T.ViewModelType else { return }
        infoView.configure(for: viewModel)
    }
    
    override func prepareForReuse() {
        infoView.clear()
    }
    
}
