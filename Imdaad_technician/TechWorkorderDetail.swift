//
//  TechWorkorderDetail.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 24/04/21.
//

import UIKit

class TechWorkorderDetail: UIViewController {
    
    var droplist: String?
    var tokid: String?
    var selected_index = 0
    var det = [wkdetails]()
    
    @IBOutlet weak var dropBtn: UIButton!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var sgTextOnlyBar: WMSegment!
    
    @IBOutlet weak var wkordertoken: UILabel!
    @IBOutlet weak var Projectlab: UILabel!
    @IBOutlet weak var Clientlab: UILabel!
    @IBOutlet weak var clientreflab: UILabel!
    @IBOutlet weak var localtionlab: UILabel!
    @IBOutlet weak var worktypelab: UILabel!
    @IBOutlet weak var descriptionlab: UILabel!
    @IBOutlet weak var skilllab: UILabel!
    @IBOutlet weak var reportedbylab: UILabel!
    @IBOutlet weak var contactlab: UILabel!
    @IBOutlet weak var reportedonlab: UILabel!
    @IBOutlet weak var supervisorlab: UILabel!
    @IBOutlet weak var leadlab: UILabel!
    @IBOutlet weak var teamlab: UILabel!
    @IBOutlet weak var startdatelab: UILabel!
    @IBOutlet weak var enddatelab: UILabel!
    @IBOutlet weak var assetdescription: UILabel!
    var sup_id:String?
    var sup_name: String?
  
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.removeObject(forKey:"token_id")
    }
    
    @IBAction func segmentValueChange(_ sender: WMSegment) {
        print("selected index = \(sender.selectedSegmentIndex)")
        selected_index = sgTextOnlyBar.selectedSegmentIndex
        if sgTextOnlyBar.selectedSegmentIndex == 0{
          
            downloadItems()
            detailView.alpha = 1
            
          
        }else if sgTextOnlyBar.selectedSegmentIndex == 1{
         
           // downloadItems()
            detailView.alpha = 0
        
        }else if sgTextOnlyBar.selectedSegmentIndex == 2{
        
//downloadItems()
            detailView.alpha = 0
          
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
   
        sgTextOnlyBar.selectorType = .bottomBar
        sgTextOnlyBar.SelectedFont = UIFont(name: "ChalkboardSE-Bold", size: 15)!
        sgTextOnlyBar.normalFont = UIFont(name: "ChalkboardSE-Regular", size: 15)!
        dropView.isHidden = true
        dropBtn.layer.borderWidth = 0.3
        dropBtn.layer.borderColor = UIColor.black.cgColor
        downloadItems()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func dropdownTapped(_ sender: Any) {
        if dropView.isHidden == false{
            dropView.isHidden = true
        }else if dropView.isHidden == true{
            dropView.isHidden = false
        }
    }
    
    @IBAction func enroutbtn(_ sender: Any) {
        
        droplist = "unassign"
        dropView.isHidden = true
        dropBtn.setTitle("Enroute", for: .normal)
        
    }
    
    @IBAction func onsitebtn(_ sender: Any) {
        droplist = "unassign"
        dropView.isHidden = true
        dropBtn.setTitle("Onsite", for: .normal)
    }
    
    
    @IBAction func startjob(_ sender: Any) {
        droplist = "unassign"
        dropView.isHidden = true
        dropBtn.setTitle("Start Job", for: .normal)
    }
    

    @IBAction func fieldcompletebtn(_ sender: Any) {
        droplist = "Completed"
        dropView.isHidden = true
        dropBtn.setTitle("Field Complete", for: .normal)

    }
    
    func createnotify() {
        
        guard let employee_id = UserDefaults.standard.value(forKey: "employee_id") as? String else {return}
        
        guard let token_id = UserDefaults.standard.value(forKey: "token_id") as? String else {return}

        let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/notification-create.php")! as URL)
            request.httpMethod = "POST"
            let postString = "employee_token=\(sup_id!)&work_order_token=\(token_id)&title=\(token_id) assigned successfully&is_seen=1&id=\(employee_id)&message=Workorder \(token_id) has been assigned to \(sup_name!)"
            print("postString \(postString)")
            request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
              data, response, error in
              if error != nil {
                print("error=\(String(describing: error))")
                return
              }
              print("response = \(String(describing: response))")
              let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
              print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        
    }
    
    @IBAction func holdbtn(_ sender: Any) {
    }
    
    
    @IBAction func SubmitBtnTapped(_ sender: Any) {
        
        guard let token = UserDefaults.standard.value(forKey: "token_id") as? String else {return}

        if droplist == "Completed"{
            let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/imdaad_technician_status_update.php")! as URL)
            request.httpMethod = "POST"
            let postString = "status_token=Completed&work_type_token=\(token)"
            print("--------->>>>>\(token)")
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
            print("error=\(String(describing: error))")
            return
            }
            self.createnotify()
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
         //  self.refreshresponse()
            }
            
            task.resume()
            let alertController = UIAlertController(title:"",message:"Status Submitted Successfully",preferredStyle:.alert)
            self.present(alertController,animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 2, repeats:false, block: {_ in
                self.dismiss(animated: true, completion: nil)
            })})
            
        }else{
        let request = NSMutableURLRequest(url: NSURL(string: "https://appstudio.co/iOS/imdaad_technician_status_update.php")! as URL)
        request.httpMethod = "POST"
        let postString = "status_token=\(droplist ?? "")&work_type_token=\(token)"
        print("--------->>>>>\(token)")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        if error != nil {
        print("error=\(String(describing: error))")
        return
        }
       
        print("response = \(String(describing: response))")
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
     //  self.refreshresponse()
        }
        task.resume()
        let alertController = UIAlertController(title:"",message:"Status Submitted Successfully",preferredStyle:.alert)
        self.present(alertController,animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 2, repeats:false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
        
    }
    }
    
    func downloadItems() {
        guard let token = UserDefaults.standard.value(forKey: "token_id") as? String else {return}
        
           let request = NSMutableURLRequest(url: NSURL(string:"https://appstudio.co/iOS/imdaad_technician_workorder_details.php")! as URL)
               request.httpMethod = "POST"
               let postString = "work_type_token=\(token)"
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
               let wkordertoken = jsonElement["work_type_token"] as? String
               let client = jsonElement["client_name"] as? String
               let sdateTime = jsonElement["date_time"] as? String
               let edateTime = jsonElement["date_time"] as? String
               let clientref = jsonElement["client_ref_id"] as? String
               let location = jsonElement["location"] as? String
               let worktype = jsonElement["work_type"] as? String
               let project = jsonElement["work_type"] as? String
               let clientcontact = jsonElement["client_contact"] as? String
               let description = jsonElement["description"] as? String
               let leadname = jsonElement["lead_name"] as? String
               let reportedby = jsonElement["reported_by"] as? String
               let reportedOn = jsonElement["reported_by"] as? String
               let assetdesc = jsonElement["asset_description"] as? String
            let skill = jsonElement["title"] as? String
            let supervisor = jsonElement["supervisor_name"] as? String
            
                let supervisor_id = jsonElement["supervisor_id"] as? String
            
            det.append(wkdetails(proj: project, clientname: client, clientreflab: clientref, location: location, wktype: worktype, desc: description!, skill: skill, reportedby: reportedby, contact: clientcontact, reportedon: reportedOn, supervisor: supervisor, lead: leadname, starteddate: sdateTime, endate: edateTime, asset: assetdesc, wkordertoken: wkordertoken,supervisor_id: supervisor_id))
             
                
                   
               }
           DispatchQueue.main.async(execute: { [self] () -> Void in
  
            for i in det{
                
                self.Projectlab.text = i.proj
                self.Clientlab.text = i.clientname
                self.clientreflab.text = i.clientreflab
                self.localtionlab.text = i.location
                self.worktypelab.text = i.wktype
                self.descriptionlab.text = i.desc
                self.skilllab.text = i.skill
                self.reportedbylab.text = i.reportedby
                self.contactlab.text = i.contact
                self.reportedonlab.text = i.starteddate
                self.supervisorlab.text = i.supervisor
                self.leadlab.text =  i.lead
                self.startdatelab.text = i.starteddate
                self.enddatelab.text = i.endate
                self.assetdescription.text = i.asset
                self.wkordertoken.text = i.wkordertoken
                sup_id = i.supervisor_id
                sup_name = i.supervisor
                
            }
           })
           }
}
struct wkdetails{
    
    var proj: String?
    var clientname: String?
    var clientreflab: String?
    var location: String?
    var wktype: String?
    var desc:String?
    var skill: String?
    var reportedby: String?
    var contact:String?
    var reportedon: String?
    var supervisor: String?
    var lead: String?
    var starteddate: String?
    var endate: String?
    var asset: String?
    var wkordertoken: String?
    var supervisor_id: String?
    
    
    
    
}
