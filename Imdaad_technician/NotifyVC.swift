//
//  NotifyVC.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 24/04/21.
//

import UIKit

class NotifyVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var notificationdetails = [Ndetails]()
   
    @IBOutlet weak var ntable: UITableView!
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ntable.delegate = self
        ntable.dataSource = self
        
        downloadItems()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as! notifytabCell
        cell.datelab.text = notificationdetails[indexPath.row].date_time
        cell.titlelab.text = notificationdetails[indexPath.row].title
        cell.msglab.text = notificationdetails[indexPath.row].message
        return cell
        
    }
    
    func downloadItems() {
        guard let employeeid = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}
        
        
           let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_technician_notification.php")! as URL)
               request.httpMethod = "POST"
               let postString = "employee_token=\(employeeid)"
               print("postString \(postString)")
               request.httpBody = postString.data(using: String.Encoding.utf8)
           let task = URLSession.shared.dataTask(with: request as URLRequest) {
                 data, response, error in
                 if error != nil {
                   print("error=\(String(describing: error))")
                   return
                 }
                 self.parseJSON(data!)
                 print("response = \(String(describing: response))")
                 let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                 print("responseString = \(String(describing: responseString))")
               }
               task.resume()
           
       }
   
       
       func parseJSON(_ data:Data) {
           var jsonResult = NSArray()
               do{
                   jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
               } catch let error as NSError {
                   print(error)
               }
               var jsonElement = NSDictionary()
           let stocks = NSMutableArray()
           for i in 0 ..< jsonResult.count
                {
               print("The count is \(jsonResult.count)")
               jsonElement = jsonResult[i] as! NSDictionary
                   //the following insures none of the JsonElement values are nil through optional binding
               if let title = jsonElement["title"] as? String,
                  let wkordertoken = jsonElement["work_order_token"] as? String,
               let msg = jsonElement["message"] as? String,
               let dateTime = jsonElement["date_time"] as? String,
               let isseen = jsonElement["is_seen"] as? String
               {
               let formatter = DateFormatter()
               formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
               let datetime = formatter.date(from: "\(jsonElement["date_time"] as! String)")
               let dateformatter = DateFormatter()
               dateformatter.dateFormat = "dd/MM/yyyy"
               let datetostring = dateformatter.string(from: datetime!)
               print("datetime \(datetime) \(jsonElement["TaskDate"] as? String) \(datetostring)")
               
                notificationdetails.append(Ndetails(wkordertoken: wkordertoken, title: title, message: msg, date_time: datetostring,is_seen: isseen))
                   
                   }
               }
           DispatchQueue.main.async(execute: { [self] () -> Void in
            ntable.reloadData()
            
           })
           }
       

    
}
struct Ndetails{
    
    var wkordertoken: String?
    var title: String?
    var message: String?
    var date_time: String?
    var is_seen: String?
    
    
}
