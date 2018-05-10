/// Copyright (c) 2018 InterviewMe: Tianyu Liang, Somi Singh, Henry Vuong
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  @IBAction func didCancel(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)

  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func signUpButton(_ sender: Any) {

        // set user properties
        let newUserAccount = UserAccount()
        newUserAccount.first_name = self.firstNameTextField.text!
        newUserAccount.last_name = self.lastNameTextField.text!
        newUserAccount.username = self.emailTextField.text!
        newUserAccount.email = self.emailTextField.text!
        newUserAccount.password = passwordTextField.text
        newUserAccount.biography = ""
        newUserAccount.profile_image = PFFile(name: "profile_image.png", data: UIImagePNGRepresentation(UIImage(named: "noprofileimage")!)!)!
 
        // sign up function for PFUser
        newUserAccount.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    // called when touches outside UI Text Field Element
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}
