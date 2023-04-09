//
//  MyTableViewCell.swift
//  MovieHjh
//
//  Created by 황재하 on 4/6/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieRank: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var audiCntDay: UILabel!
    @IBOutlet weak var audiCntTotal: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
