//
//  InventoryViewController.swift
//  Assessment
//
//  Created by admin on 13/10/22.
//

import UIKit

class InventoryViewController: UIViewController {
    
    @IBOutlet weak var vinLbl: UILabel!
    
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var makeLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var mileLbl: UILabel!
    
    @IBOutlet weak var vinTxtFld: UITextField!
    @IBOutlet weak var yearTxtFld: UITextField!
    @IBOutlet weak var modelTxtFld: UITextField!
    @IBOutlet weak var makeTxtFld: UITextField!
    @IBOutlet weak var extcolorTxtFld: UITextField!
    @IBOutlet weak var mileageTxtFld: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func AddItems(_ sender: Any) {
        self.setUpPostmethod()
    }
    
    
    func setUpPostmethod(){
        guard let vin = self.vinTxtFld.text else { return }
        guard let year = self.yearTxtFld.text else { return }
        guard let model = self.modelTxtFld.text else { return }
        guard let make = self.makeTxtFld.text else { return }
        guard let extcolor = self.extcolorTxtFld.text else { return }
        guard let mileage = self.mileageTxtFld.text else { return }
        
        let token = "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc19kZWxldGVkIjpmYWxzZSwiX2lkIjoxLCJlbWFpbCI6InJzc2luZG9yZTAxdGVhbWxlYWRAZ21haWwuY29tIiwicm9sZV9pZCI6W3siaWQiOjEsInRpdGxlIjoic3VwZXIgYWRtaW4ifV0sImluc3RpdHV0ZV9pZCI6eyJfaWQiOjEsImNvZGUiOiIxMDU4MTUiLCJ0aXRsZSI6IkhvdXN0b24gRGlyZWN0IEF1dG8ifSwiZm5hbWUiOiJNYW5vaiIsImxuYW1lIjoiU2FodSIsImlhdCI6MTY2NTcyNTY1MiwiZXhwIjoxNjY1ODEyMDUyfQ.EYFTkBC_Euwh_7hAAO4kEs0nt0Ck4IMBd_FMpGC4ypk"
        
        if let url = URL(string: "http://23.126.105.228:3000/api/inventory/addInv"){
            var request = URLRequest(url: url)
//            url.addValue(
//              "Bearer \(token)",
//              forHTTPHeaderField: "Authorization")

            request.httpMethod = "POST"
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
            
            let parameters: [String: Any] = [
                "VIN": vin,
                 "StockNumber":"",
                 "Year":year,
                 "Model":model,
                 "Make":make,
                 "BodyStyle":"",
                 "DriveType":"",
                 "Transmission":"",
                 "Engine":"",
                 "FuelType":"",
                 "ExtColor":extcolor,
                 "IntColor":"Black",
                 "Mileage":mileage,
                 "MileageStatus_ID":1,
                 "AcquiredPrice":3906,
                 "AcquiredRefNumber":"",
                 "AcquiredFromType_ID":0,
                 "AcquiredFromName":"",
                 "YearPreviousSale":"",
                 "EvaluationBidPrice":"",
                 "EvaluationOfferPrice":"",
                 "EvaluationLane":"",
                 "EvaluationNumber":"",
                 "AskPrice":"",
                 "AskDown":"",
                 "PromotionalPrice":"",
                 "WholesalePrice":"",
                 "AskTerm":"",
                 "PakFee":"",
                 "Weight":"",
                 "UserDefined1":"",
                 "LicPlates":"",
                 "LicPlatesExpireMth":"",
                 "LicPlatesExpireYear":"",
                 "InspExpireMth":"",
                 "InspExpireYear":"",
                 "ValNumber":"",
                 "Inspected":false,
                 "EmmissionsNumber":"",
                 "COTName":"",
                 "COTPhone1":"",
                 "COTFax1":"",
                 "COTCountry":"",
                 "COTAdd1":"",
                 "COTAdd2":"",
                 "COTZip":"",
                 "COTCity":"",
                 "COTState":"",
                 "COTCounty":"",
                 "LienBalance":"",
                 "LienName":"",
                 "LienAcctNumber":"",
                 "LienContact":"",
                 "LienPhone1":"",
                 "LienFax1":"",
                 "LienCountry":"",
                 "LienAdd1":"",
                 "LienAdd2":"",
                 "LienZip":"",
                 "LienCity":"",
                 "LienState":"",
                 "LienCounty":""
            ]
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        DispatchQueue.main.async {
                            print("Status code :- \(response.statusCode)")
                            print(response)
                        }
                        
                        return
                    }
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async {
                        print(json)
                        self.showAlert()
                    }
                   
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    func showAlert(){
        // create the alert
           let alert = UIAlertController(title: "Success", message: "The Inventory has been successfully added", preferredStyle: UIAlertController.Style.alert)

           // add the actions (buttons)
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           //alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

           // show the alert
           self.present(alert, animated: true, completion: nil)
       }
    }
//}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
