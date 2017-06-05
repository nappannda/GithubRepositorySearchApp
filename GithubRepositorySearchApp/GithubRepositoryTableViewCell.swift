//
//  GithubRepositoryTableViewCell.swift
//  GithubRepositorySearchApp
//
//  Created by 上原和輝 on 2017/06/05.
//  Copyright © 2017年 nappannda. All rights reserved.
//

import UIKit

class GithubRepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCell(repository: GithubRepository) {
        repositoryNameLabel.text = repository.name
        ownerNameLabel.text = repository.user?.name
        starCountLabel.text = "星:" + (repository.starNumber?.description)!
        languageNameLabel.text = repository.language
    }

}
