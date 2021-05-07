//
//  ViewController.swift
//  DownloadApp
//
//  Created by Dannian Park on 2021/05/06.
//

import UIKit

import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var successDatas : [Int] = []
    var failedDatas : [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.testForThumbnail()
    }

    private func testForThumbnail() {
        DispatchQueue(label: "testqueue", qos: .background, autoreleaseFrequency: .workItem).async {
            let sema = DispatchSemaphore(value: 0)
            
            for i in 1351 ... 1600 {
                print("i: \(i)")
                DispatchQueue.main.async {
                    let uiimage : UIImageView = .init()
                    guard let url = URL(string: "https://api.salted.ltd/api/open/data/golf/\(i)/t"), let vurl = URL(string: "https://api.salted.ltd/api/open/data/golf/\(i)/v") else {
                        self.failedDatas.append(i)
                        return
                    }
                    uiimage.kf.setImage(with: url, placeholder: nil, options: nil) { (prog1, prog2) in
                        
                    } completionHandler: { (result) in
                        print("Result : result \(result)")
                        switch result {
                        case .success(let value) :
                            let test = value.image
                            print("Value? : \(test) :: \(value.image) \(value)")
                            print("Breaker")
                            if let imageData = value.image.pngData() {
                                let bytes = imageData.count
                                if bytes > 0 {
                                    let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
                                    
                                    AF.download(vurl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, to: destination).downloadProgress(closure: { (progress) in
                                        
                                        //print("Check progress :: \(progress)")
                                    }).response { (defaultResponder) in
                                        print("default responder : \(defaultResponder)")
                                        self.successDatas.append(i)
                                        sema.signal()
                                    }
                                }else{
                                    self.failedDatas.append(i)
                                    sema.signal()
                                }
                            }else{
                                self.failedDatas.append(i)
                                sema.signal()
                            }
                            break
                        case .failure(let error) :
                            print("Error : \(error)")
                            self.failedDatas.append(i)
                            sema.signal()
                            break
                        }
                    }
                }
                if sema.wait(timeout: .now() + 1000) == .success {
                    print("Time out success : \(i)")
                }else{
                    print("Time out failed : \(i)")
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
        }
    }
    
    private func allComplete() {
        
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? UITableViewCell else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: "tableCell")
        }
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(self.successDatas[indexPath.row])"
            cell.detailTextLabel?.text = "success"
        }else if indexPath.section == 1 {
            cell.textLabel?.text = "\(self.failedDatas[indexPath.row])"
            cell.detailTextLabel?.text = "failed"
        }else{
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.successDatas.count
        }
        else if section == 1 {
            return self.failedDatas.count
        }
        else{
            return 0
        }
    }
    
}
