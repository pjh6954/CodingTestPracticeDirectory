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
    func selectedBtnBGChange(_ sender: UIButton)
    func selectedBtnBGChange(_ index: IndexPath, btnNum: Int)
}

extension TableViewCellDelegate {
    func selectedWithIndex(_ index : IndexPath, type: selectType) {
        // 해당 delegate protocol을 이용할 때 꼭 적어주지 않아도 되도록 하기 위해 extension에 작성
    }
    func selectedBtnBGChange(_ sender: UIButton) {
        // 직접 해당 btn 접근
    }
    func selectedBtnBGChange(_ index: IndexPath, btnNum: Int) {
        // table view를 reload해서 사용하게 하기 위함
    }
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var btnOtherColor: UIButton!
    
    @IBOutlet private var buttons : Array<UIButton>?
    
    public var btnCount : Int {
        get {
            return buttons?.count ?? 0
        }
    }
    
    private let btnBackgroundColor : UIColor = .green
    
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
    
    public func setData(_ model : TableCellDataModel) {
        self.backgroundColor = model.backgroundColor
    }
    
    public func setData(_ model : TableBtnAndBGColorData, colorBtnNum: Int = 0) {
        self.backgroundColor = model.backgroundColor
        for btn in self.buttons ?? [] {
            btn.backgroundColor = model.btnColor//btnBackgroundColor
        }
        // 또는 button들에 각각 tag를 넣어서 해당하는 colorbtnnum과 tag를 맞춰주는 식으로 구현하셔도 될 것 같습니다.
        switch colorBtnNum {
        case 1:
            self.btnOtherColor.backgroundColor = btnBackgroundColor
        case 2:
            self.btnSelect.backgroundColor = btnBackgroundColor
        default:
            break
        }
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        guard let indexPath = self.indexPath else {
            return
        }
        self.delegate?.selectedWithIndex(indexPath, type: .green)
        self.delegate?.selectedBtnBGChange(sender)
        self.delegate?.selectedBtnBGChange(indexPath, btnNum: 2)
    }
    @IBAction func btnActionOtherColor(_ sender: UIButton) {
        guard let indexPath = self.indexPath else {
            return
        }
        self.delegate?.selectedWithIndex(indexPath, type: .orange)
        self.delegate?.selectedBtnBGChange(sender)
        self.delegate?.selectedBtnBGChange(indexPath, btnNum: 1)
    }
}
