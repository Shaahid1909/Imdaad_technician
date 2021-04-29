//
//  TechWorkOrderCell.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 24/04/21.
//

import UIKit

class TechWorkOrderCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var wktypTokenlab: UILabel!
    @IBOutlet weak var wktype: UILabel!
    @IBOutlet weak var supervisorlab: UILabel!
    @IBOutlet weak var dateandtimelab: UILabel!
    @IBOutlet weak var locationlab: UILabel!
    @IBOutlet weak var prioritylab: UILabel!
    @IBOutlet weak var alertImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layerView.layer.masksToBounds = false
        layerView.layer.shadowRadius = 4
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowColor = UIColor.gray.cgColor
        layerView.layer.shadowOffset = CGSize(width: 0 , height:6)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
