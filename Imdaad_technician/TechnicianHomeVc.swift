//
//  TechnicianHomeVc.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 23/04/21.
//

import UIKit

class TechnicianHomeVc: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var emptyvieww: UIView!
    @IBOutlet weak var totalworks: UILabel!
    var wkorder = [workorderData]()
    var emp_id: String?
    var urlpath:String?
    var selected_index = 0
    var selected:String?
    
    
    var a:[String] = []
    var AssignWkList = [workorderData]()
    var PendingWKList = [workorderData]()
    var CompletedWKList = [workorderData]()
    
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var filterVieww: UIView!
    @IBOutlet weak var sgTextOnlyBar: WMSegment!
    
    
    @IBAction func unwindToMenu1(segue: UIStoryboardSegue) {
             
    }
    
    
    @IBAction func notificationTapped(_ sender: Any) {
        performSegue(withIdentifier: "notify", sender: self)
    }
    
    @IBAction func exitBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.removeSpinner()
    }
    //    override func viewWillAppear(_ animated: Bool) {
//
//        wkorder.removeAll()
//        downloadItems()
//        tabView.reloadData()
//
//    }
  //  var nSelectedSegmentIndex : Int = 1
    
    override func viewWillAppear(_ animated: Bool) {
        AssignWkList.removeAll()
        PendingWKList.removeAll()
        CompletedWKList.removeAll()
        downloadItems()
        tabView.reloadData()
        let returnValue = UserDefaults.standard.integer(forKey: "selected_index")
        sgTextOnlyBar.selectedSegmentIndex = returnValue
        print("returnValue : \(returnValue)")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tabView.reloadData()
        tabView.delegate = self
        tabView.dataSource = self
        
        
        sgTextOnlyBar.selectorType = .bottomBar
       sgTextOnlyBar.SelectedFont = UIFont(name: "ChalkboardSE-Bold", size: 15)!
        sgTextOnlyBar.normalFont = UIFont(name: "ChalkboardSE-Regular", size: 15)!
        
      
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 214
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        if selected_index == 0{
            tabView.alpha = 1
            totalworks.text = "\(AssignWkList.count)"
            return AssignWkList.count
        } else if selected_index == 1{
            totalworks.text = "\(PendingWKList.count)"
            return PendingWKList.count
        }else if selected_index == 2{
            totalworks.text = "\(CompletedWKList.count)"
            return CompletedWKList.count
        
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
          if selected_index == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "techwkorder", for: indexPath) as! TechWorkOrderCell
                    if AssignWkList[indexPath.row].priority == "0"{
                    cell.prioritylab.text = ""
                    cell.alertImg.image = UIImage(named: "")
                    }else{
                    cell.prioritylab.text = "High Priority"
                    cell.alertImg.image = UIImage(named: "alert")
                    }
                    cell.wktypTokenlab.text = AssignWkList[indexPath.row].token_id
                    cell.dateandtimelab.text = AssignWkList[indexPath.row].date_time
                    cell.locationlab.text = AssignWkList[indexPath.row].location
                    cell.supervisorlab.text = AssignWkList[indexPath.row].supervisor_name
                    cell.wktype.text = AssignWkList[indexPath.row].work_type
                  
                    return cell
                    
                }
                else if selected_index == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "techwkorder", for: indexPath) as! TechWorkOrderCell
                    if PendingWKList[indexPath.row].priority == "0"{
                    cell.prioritylab.text = ""
                    cell.alertImg.image = UIImage(named: "")
                    }else{
                    cell.prioritylab.text = "High Priority"
                    cell.alertImg.image = UIImage(named: "alert")
                    }
                    cell.wktypTokenlab.text = PendingWKList[indexPath.row].token_id
                    cell.dateandtimelab.text = PendingWKList[indexPath.row].date_time
                    cell.locationlab.text = PendingWKList[indexPath.row].location
                    cell.supervisorlab.text = PendingWKList[indexPath.row].supervisor_name
                    cell.wktype.text = PendingWKList[indexPath.row].work_type
                  
                return cell
                    
                } else if selected_index == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "techwkorder", for: indexPath) as! TechWorkOrderCell
                    if CompletedWKList[indexPath.row].priority == "0"{
                    cell.prioritylab.text = ""
                    cell.alertImg.image = UIImage(named: "")
                    }else{
                    cell.prioritylab.text = "High Priority"
                    cell.alertImg.image = UIImage(named: "alert")
                    }
                    cell.wktypTokenlab.text = CompletedWKList[indexPath.row].token_id
                    cell.dateandtimelab.text = CompletedWKList[indexPath.row].date_time
                    cell.locationlab.text = CompletedWKList[indexPath.row].location
                    cell.supervisorlab.text = CompletedWKList[indexPath.row].supervisor_name
                    cell.wktype.text = CompletedWKList[indexPath.row].work_type
                   
                    return cell
                }

                return UITableViewCell()
        
                }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "workorderdetail") as! SupervisorHomeVc
//
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        
      
        performSegue(withIdentifier: "workorderdetail", sender: self)
        tabView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "workorderdetail" {
            if segue.destination is TechWorkorderDetail {
                if selected_index == 0{
                    let indexPath = tabView.indexPathForSelectedRow
                UserDefaults.standard.set(AssignWkList[indexPath!.row].token_id, forKey: "token_id")
                      
                   
                } else  if selected_index == 1{
                    let indexPath = tabView.indexPathForSelectedRow
                UserDefaults.standard.set(PendingWKList[indexPath!.row].token_id, forKey: "token_id")
                }
            }
        
    }
    }
    
    
    
    @IBAction func segmentValueChange(_ sender: WMSegment) {
//        print("selected index = \(sender.selectedSegmentIndex)")
//        switch sender.selectedSegmentIndex {
//        case 0:
//            tabView.alpha = 1
//            print("first item")
//        case 1:
//            tabView.alpha = 0
//            filterVieww.alpha = 0
//            print("second item")
//        case 2:
//            tabView.alpha = 0
//            filterVieww.alpha = 0
//            print("Third item")
//        default:
//            print("default item")
//        }
        
//        if sender.selectedSegmentIndex == 0 {
//              self.nSelectedSegmentIndex = 1
//          }
//          else {
//              self.nSelectedSegmentIndex = 2
//          }
//          self.tabView.reloadData()
        
        selected_index = sgTextOnlyBar.selectedSegmentIndex
        if sgTextOnlyBar.selectedSegmentIndex == 0{
            UserDefaults.standard.removeObject(forKey:"token_id")
            AssignWkList.removeAll()
            downloadItems()
            tabView.reloadData()
        }else if sgTextOnlyBar.selectedSegmentIndex == 1{
            UserDefaults.standard.removeObject(forKey:"token_id")
            PendingWKList.removeAll()
            downloadItems()
            tabView.reloadData()
        }else if sgTextOnlyBar.selectedSegmentIndex == 2{
            UserDefaults.standard.removeObject(forKey:"token_id")
            CompletedWKList.removeAll()
            downloadItems()
            tabView.reloadData()
        }
        print("selected_index : \(selected_index)")
        tabView.reloadData()
        
        
    }
    
    func downloadItems() {
     
        guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}


        let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_technician_retrieve.php")! as URL)
            request.httpMethod = "POST"
            let postString = "employee_id=\(employee_id)"
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
       jsonElement = jsonResult[i] as! NSDictionary
       a.append(jsonElement["status_token"] as! String)
       print("assign : \(jsonElement["status_token"] as! String) \(a)")
       if jsonElement["status_token"] as! String == "assign"{
        AssignWkList.append(workorderData(token_id: jsonElement["work_type_token"] as? String, supervisor_name: jsonElement["supervisor_name"] as? String, date_time: jsonElement["date_time"] as? String,location: jsonElement["location"] as? String,workorders: jsonElement["work_order_count"] as? String,priority:  jsonElement["is_high_priority"] as? String,work_type: jsonElement["work_type"] as? String))
       }else if jsonElement["status_token"] as! String == "Completed"{
        CompletedWKList.append(workorderData(token_id: jsonElement["work_type_token"] as? String, supervisor_name: jsonElement["supervisor_name"] as? String, date_time: jsonElement["date_time"] as? String, location: jsonElement["location"] as? String,workorders: jsonElement["work_order_count"] as? String,priority:  jsonElement["is_high_priority"] as? String,work_type: jsonElement["work_type"] as? String))
       }else if jsonElement["status_token"] as! String == "Enroute"{
        PendingWKList.append(workorderData(token_id: jsonElement["work_type_token"] as? String, supervisor_name: jsonElement["supervisor_name"] as? String, date_time: jsonElement["date_time"] as? String, location: jsonElement["location"] as? String,workorders: jsonElement["work_order_count"] as? String,priority:  jsonElement["is_high_priority"] as? String,work_type: jsonElement["work_type"] as? String))
           print("pending_work_order_list : \(PendingWKList)")
        
       }else if jsonElement["status_token"] as! String == "Onsite"{
        PendingWKList.append(workorderData(token_id: jsonElement["work_type_token"] as? String, supervisor_name: jsonElement["supervisor_name"] as? String, date_time: jsonElement["date_time"] as? String, location: jsonElement["location"] as? String,workorders: jsonElement["work_order_count"] as? String,priority:  jsonElement["is_high_priority"] as? String,work_type: jsonElement["work_type"] as? String))
           print("pending_work_order_list : \(PendingWKList)")
        
       }else if jsonElement["status_token"] as! String == "Start Job"{
        PendingWKList.append(workorderData(token_id: jsonElement["work_type_token"] as? String, supervisor_name: jsonElement["supervisor_name"] as? String, date_time: jsonElement["date_time"] as? String, location: jsonElement["location"] as? String,workorders: jsonElement["work_order_count"] as? String,priority:  jsonElement["is_high_priority"] as? String,work_type: jsonElement["work_type"] as? String))
           print("pending_work_order_list : \(PendingWKList)")
       }
       
       print("work_order_list : \(PendingWKList) \(CompletedWKList) \(PendingWKList)")
       }
        DispatchQueue.main.async(execute: { [self] () -> Void in
            itemsDownloaded(items: stocks)

        })
        }
    func itemsDownloaded(items: NSArray) {
       
        self.tabView.reloadData()
      }
    

}
struct workorderData {
    var token_id:String?
    var supervisor_name:String?
    var date_time:String?
    var location:String?
    var workorders:String?
    var priority:String?
    var work_type:String?
    

}

