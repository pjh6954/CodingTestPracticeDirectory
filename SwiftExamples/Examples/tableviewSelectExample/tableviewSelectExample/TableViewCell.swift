//
//  TableViewCell.swift
//  tableviewSelectExample
//
//  Created by Dannian Park on 2021/05/26.
//

import UIKit

public enum selectType {
    case green
    case orange
}

protocol TableViewCellDelegate: AnyObject {
    func selectedWithIndex(_ index: IndexPath, type: selectType)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var btnOtherColor: UIButton!
    
    public weak var delegate : TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        guard let indexPath = self.indexPath else {
            return
        }
        self.delegate?.selectedWithIndex(indexPath, type: .green)
    }
    @IBAction func btnActionOtherColor(_ sender: UIButton) {
        guard let indexPath = self.indexPath else {
            return
        }
        self.delegate?.selectedWithIndex(indexPath, type: .orange)
    }
    
}
