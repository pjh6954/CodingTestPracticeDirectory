//
//  ViewController.swift
//  PickerViewExample
//
//  Created by Dannian Park on 2021/05/27.
//

import UIKit

enum selectedPickerType {
    case locationType
    case stationType
    case totalType
}

class ViewController: UIViewController {
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnStation: UIButton!
    
    @IBOutlet weak var btnTotalPicker: UIButton!
    @IBOutlet weak var stackview: UIStackView!
    private var pickerView : UIPickerView!
    private var alertController : UIAlertController!
    let screenWidth = UIScreen.main.bounds.width - 50
    let screenHeight = UIScreen.main.bounds.height / 2
    
    
    private var data : locationsModel!
    private let location : [(String, Int)] = [
        ("서울", 0),
        ("부산", 1)
    ]
    private let seoulStations : [(String, Int)] = [
        ("당산", 0),
        ("영등포", 1),
        ("사당", 2),
        ("역삼", 3),
        ("강남", 4)
    ]
    private let busanStations : [(String, Int)] = [
        ("해운대", 0),
        ("광안리", 1),
        ("수영", 2)
    ]
    
    private var pickerType : selectedPickerType = .locationType
    private var selectedLocationIndex : Int = 0 {
        didSet {
            self.btnLocation.setTitle(self.data.datas[self.selectedLocationIndex].name, for: .normal)
            if self.selectedLocationIndex != oldValue {
                self.selectedStationIndex = 0
            }
        }
    }
    private var selectedStationIndex : Int = 0 {
        didSet {
            self.btnStation.setTitle(self.data.datas[self.selectedLocationIndex].stations[selectedStationIndex].name, for: .normal)
        }
    }
    private var selectedTotalIndex: (Int, Int) = (0, 0) {
        didSet {
            let selectObj = self.data.datas[selectedTotalIndex.0]
            self.btnTotalPicker.setTitle("\(selectObj.name) :: \(selectObj.stations[selectedTotalIndex.1].name)", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.settingData()
        self.config()
        self.createPickerView()
    }
    
    private func settingData() {
        guard let getFile = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("Check?")
            return
        }
        // or using swiftJson library.
        do {
            print("Check2?")
            let data = try Data(contentsOf: getFile)
            print("Check4? : \(data)")
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            print("Check5?")
            if let jsonResult = json as? Dictionary<String, AnyObject> {
                let resultCd = jsonResult["resultCd"] as? String
                print("jsonresult : \(jsonResult) :: \(resultCd)")
                // Make model
            }else{
                print("Check3")
            }
        } catch {
            print("Error : \(error)")
        }
    }
    
    private func config() {
        self.btnLocation.addTarget(self, action: #selector(actionBtnLocation(_:)), for: .touchUpInside)
        self.btnStation.addTarget(self, action: #selector(actionBtnStation(_:)), for: .touchUpInside)
        self.btnTotalPicker.addTarget(self, action: #selector(actionBtnTotalPicker(_:)), for: .touchUpInside)
        self.data = .init(datas: [])
        for element in location {
            if element.0.elementsEqual("서울") || element.1 == 0 {
                var stations : [station] = []
                for station in seoulStations {
                    let stationModel : station = .init(setName: station.0, setKey: station.1)
                    stations.append(stationModel)
                }
                let location : location = .init(setName: element.0, setKey: element.1, stations: stations)
                self.data.updateData(insert: location)
            }else if element.0.elementsEqual("부산") || element.1 == 1 {
                var stations : [station] = []
                for station in busanStations {
                    let stationModel : station = .init(setName: station.0, setKey: station.1)
                    stations.append(stationModel)
                }
                let location : location = .init(setName: element.0, setKey: element.1, stations: stations)
                self.data.updateData(insert: location)
            }
        }
        
        self.selectedLocationIndex = 0
        self.selectedStationIndex = 0
        self.selectedTotalIndex = (0, 0)
    }
    
    private func createPickerView() {
        
        //pickerView = UIPickerView()
        //pickerView.delegate = self
        let vc = UIViewController()
        vc.preferredContentSize = .init(width: screenWidth, height: screenHeight)
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.popoverPresentationController?.sourceView = stackview
        alert.popoverPresentationController?.sourceRect = stackview.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { action in
            switch self.pickerType {
            case .locationType:
                let index = self.pickerView.selectedRow(inComponent: 0)
                self.selectedLocationIndex = index
                break
            case .stationType:
                self.selectedStationIndex = self.pickerView.selectedRow(inComponent: 0)
                break
            case .totalType:
                self.selectedTotalIndex = (self.pickerView.selectedRow(inComponent: 0), self.pickerView.selectedRow(inComponent: 1))
                break
            }
        }))
        
        self.alertController = alert
    }
    
    @objc private func actionBtnLocation(_ sender: UIButton) {
        self.pickerType = .locationType
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(self.selectedLocationIndex, inComponent: 0, animated: false)
        self.present(self.alertController, animated: true, completion: nil)
    }
    
    @objc private func actionBtnStation(_ sender: UIButton) {
        self.pickerType = .stationType
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(self.selectedStationIndex, inComponent: 0, animated: false)
        self.present(self.alertController, animated: true, completion: nil)
    }
    
    @objc private func actionBtnTotalPicker(_ sender: UIButton) {
        self.pickerType = .totalType
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(self.selectedTotalIndex.0, inComponent: 0, animated: false)
        self.pickerView.selectRow(self.selectedTotalIndex.1, inComponent: 1, animated: false)
        self.present(self.alertController, animated: true, completion: nil)
    }
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch self.pickerType {
        case .totalType:
            return 2
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.pickerType {
        case .locationType:
            return self.data.datas.count
        case .stationType:
            return self.data.getData(componentIndex: self.selectedLocationIndex).stations.count
        case .totalType:
            if component == 0 {
                return self.data.datas.count
            } else {
                return self.data.getData(componentIndex: pickerView.selectedRow(inComponent: 0)).stations.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.pickerType {
        case .locationType:
            return self.data.datas[row].name
        case .stationType:
            return self.data.getData(componentIndex: self.selectedLocationIndex).stations[row].name
        case .totalType:
            if component == 0 {
                return self.data.datas[row].name
            } else {
                return self.data.getData(componentIndex: pickerView.selectedRow(inComponent: 0)).stations[row].name
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.pickerType == .totalType, component == 0 {
            pickerView.reloadComponent(1)
        }
    }
}


