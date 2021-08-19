//
//  ViewController.swift
//  JSONAPIExample
//
//  Created by Dannian Park on 2021/08/04.
//

import UIKit

import Alamofire
// import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        search(name: "")
    }

    func search(name: String) {
        let url = "https://api.finance.naver.com/siseJson.naver?symbol=005930&requestType=1&startTime=20210404&endTime=20210514&timeframe=day"
        AF.request(url, method: .get, encoding: JSONEncoding.default).validate()
            .responseString { response in
                /*
                 "\n [[\'날짜\', \'시가\', \'고가\', \'저가\', \'종가\', \'거래량\', \'외국인소진율\'],\n\n\t\n\t\n\t\t\n[\"20210405\", 85800, 86000, 84800, 85400, 16255990, 54.73],\n\t\t\n[\"20210406\", 86200, 86200, 85100, 86000, 19042023, 54.8],\n\t\t\n[\"20210407\", 86100, 86200, 85400, 85600, 17885538, 54.82],\n\t\t\n[\"20210408\", 85700, 85700, 84100, 84700, 19244259, 54.83],\n\t\t\n[\"20210409\", 84700, 84900, 83400, 83600, 18193707, 54.79],\n\t\t\n[\"20210412\", 84100, 84100, 83100, 83200, 12915282, 54.78],\n\t\t\n[\"20210413\", 83000, 84500, 82800, 84000, 15238206, 54.8],\n\t\t\n[\"20210414\", 84000, 84300, 83400, 84000, 13794652, 54.79],\n\t\t\n[\"20210415\", 83700, 84500, 83400, 84100, 16377412, 54.81],\n\t\t\n[\"20210416\", 84700, 84700, 83600, 83900, 15429522, 54.81],\n\t\t\n[\"20210419\", 83800, 84000, 83300, 83300, 15287311, 54.76],\n\t\t\n[\"20210420\", 83300, 84000, 83100, 83900, 15521965, 54.78],\n\t\t\n[\"20210421\", 83300, 83500, 82500, 82600, 21636079, 54.72],\n\t\t\n[\"20210422\", 82900, 83000, 82400, 82400, 13934746, 54.68],\n\t\t\n[\"20210423\", 81900, 82900, 81600, 82800, 17805080, 54.67],\n\t\t\n[\"20210426\", 82900, 83500, 82600, 83500, 15489938, 54.7],\n\t\t\n[\"20210427\", 83200, 83300, 82500, 82900, 12941533, 54.7],\n\t\t\n[\"20210428\", 83200, 83200, 82100, 82100, 15596759, 54.69],\n\t\t\n[\"20210429\", 82400, 82500, 81500, 81700, 20000973, 54.61],\n\t\t\n[\"20210430\", 81900, 82100, 81500, 81500, 18673197, 54.59],\n\t\t\n[\"20210503\", 81000, 82400, 81000, 81700, 15710336, 54.55],\n\t\t\n[\"20210504\", 81900, 82600, 81800, 82600, 12532550, 54.55],\n\t\t\n[\"20210506\", 81700, 82300, 81700, 82300, 17047511, 54.49],\n\t\t\n[\"20210507\", 81800, 82100, 81500, 81900, 14154882, 54.46],\n\t\t\n[\"20210510\", 82300, 83500, 81800, 83200, 19385027, 54.47],\n\t\t\n[\"20210511\", 82500, 82600, 81100, 81200, 28996680, 54.31],\n\t\t\n[\"20210512\", 80800, 81200, 79800, 80000, 35812268, 54.07],\n\t\t\n[\"20210513\", 78900, 79600, 78400, 78500, 31490096, 53.89],\n\t\t\n[\"20210514\", 79000, 80300, 78900, 80100, 16450920, 53.9]\n\t\t\n\t\n\n]\n"
                 */
                switch response.result {
                case .success(let value):
                    // let newValue = value.trimmingCharacters(in: .whitespacesAndNewlines) // not working
                    let newValue = String(value.filter { !" \n\t\r".contains($0) }).replacingOccurrences(of: "\'", with: "\"")
                    // print("NewValue : \(newValue)")
                    var returnArr: [Model] = []
                    if let data = newValue.data(using: .utf8) {
                        print("Data exist : \(data)")
                        /*
                        // SwiftyJSON 사용
                        let json = JSON(data)
                        print("JSON? \(json)")
                        if let arr = json.array, arr.count > 1 {
                            print("arr : \(arr)")
                            for i in 1 ..< arr.count - 1 {
                                print("Check : \(arr[i]), \(arr[i].count)")
                                if arr[i].count == 7 {
                                    let modelData = Model(date: arr[i][0].string!, price: arr[i][1].int!, highPrice: arr[i][2].int!, lowPrice: arr[i][3].int!, closingPrice: arr[i][4].int!, tradingVolume: arr[i][5].int!, burnoutRate: arr[i][6].floatValue)
                                    returnArr.append(modelData)
                                }
                            }
                        }
                        */
                        // 라이브러리 사용하지 않고 긁기
                        let jsonTest = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        print("JSON TEST : \(jsonTest)")
                        if let arr = jsonTest as? Array<[Any]>, arr.count > 1 {
                            print("JSON ARR : \(arr), \(arr[1])")
                            for i in 1 ..< arr.count - 1 {
                                print("Check : \(arr[i]), \(arr[i].count)")
                                if arr[i].count == 7 {
                                    let modelData = Model(
                                        date: arr[i][0] as! String,
                                        price: arr[i][1] as! Int,
                                        highPrice: arr[i][2] as! Int,
                                        lowPrice: arr[i][3] as! Int,
                                        closingPrice: arr[i][4] as! Int,
                                        tradingVolume: arr[i][5] as! Int,
                                        burnoutRate: (arr[i][6] as! NSNumber).floatValue)
                                    returnArr.append(modelData)
                                }
                            }
                        }
                        
                    }
                    print("MODEL ARR : \(returnArr) :: \(returnArr.count)")
                case .failure(let error):
                    print("Error? \(error)")
                }
        }
    }
}

struct Model: Codable {
    let date : String
    let price : Int
    let highPrice: Int
    let lowPrice: Int
    let closingPrice: Int
    let tradingVolume: Int
    let burnoutRate : Float
}

