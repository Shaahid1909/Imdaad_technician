//
//  ViewController.swift
//  Imdaad_project
//
//  Created by shaahid shamil on 22/04/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var vieww: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
        txtPassword.delegate = self
        vieww.layer.cornerRadius = 2
        vieww.layer.shadowColor = UIColor.black.cgColor
        vieww.layer.shadowOffset = CGSize(width: 0.5, height: 5.0);
        vieww.layer.shadowOpacity = 0.6
        vieww.layer.shadowRadius = 6.0
        HideKeyboard()
        let emailImage = UIImage(named:"id")
        addLeftImageTo(txtField: txtEmail, andImage: emailImage!)
        let passwordImage = UIImage(named:"password")
        addLeftImageTo(txtField: txtPassword, andImage: passwordImage!)

    }
    
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }

    @IBAction func logBtnTapped(_ sender: UIButton) {
       self.showSpinner(onView: self.view)
        let parameters: Parameters = ["employee_id":txtEmail.text!,"password":txtPassword.text!]
         //   activityindicator.isHidden = false
         //   activityindicator.startAnimating()
           // print("checkuser : \(checkuser)")
            if txtEmail.text!.trimmingCharacters(in: .whitespaces).isEmpty && txtPassword.text!.trimmingCharacters(in: .whitespaces).isEmpty{
                let alert = UIAlertController(title: "Alert", message: "Fill all the fields", preferredStyle: UIAlertController.Style.alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                  }
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            self.removeSpinner()
            }else {
              AF.request("https://appstudio.co/iOS/imdaad_employee_login.php", method: .post, parameters: parameters).responseJSON
              {[self]Response in
                if let result = Response.value{
                  let jsonData = result as! NSDictionary
                  print("jsonData : \(jsonData.allValues)")
                  for i in jsonData.allValues{
                   if i as! String == "technician"{
                    
                    txtEmail.text = ""
                    txtPassword.text = ""
                         // userText.text = ""
                         // passText.text = ""
                      //    activityindicator.stopAnimating()
                       //   activityindicator.isHidden = true
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let navigationController = storyBoard.instantiateViewController(withIdentifier: "SupervisorView") as! UINavigationController
                        let vc = storyBoard.instantiateViewController(withIdentifier: "TechView") as! TechnicianHomeVc
//                        navigationController.pushViewController(vc, animated: true)
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                            vc.emp_id = txtEmail.text
                            
                        
                    }else if i as! String == "failure"{
                   //   activityindicator.stopAnimating()
                 //     activityindicator.isHidden = true
                      let alert = UIAlertController(title: "Alert", message: "Check Username and Password", preferredStyle: UIAlertController.Style.alert)
                      let cancel = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
                        }
                      alert.addAction(cancel)
                      present(alert, animated: true, completion: nil)
                        self.removeSpinner()
                    }}}}}
        
        UserDefaults.standard.set(txtEmail.text, forKey: "employee_id")

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func HideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
 
  //-------DismissKeyboard
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

