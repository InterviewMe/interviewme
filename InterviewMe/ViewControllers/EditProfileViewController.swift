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

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UITextField!
    
    @IBOutlet weak var lastNameLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var biographyTextField: UITextView!
    
    var user = UserAccount.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = try! UserAccount.current()!.fetch()
        updateInfo()
        
        // tap to edit profile view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }

  
  @IBAction func didTapBackground(_ sender: Any) {
    firstNameLabel.endEditing(true)
    lastNameLabel.endEditing(true)
    emailLabel.endEditing(true)
    biographyTextField.endEditing(true)
    view.endEditing(true)
  }
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let query = PFQuery(className:"_User")
        query.getObjectInBackground(withId: user.objectId!) {
            (userObject: PFObject?, error: Error?) -> Void in
            if error != nil {
                print(error ?? "crap")
            } else if let userObject = userObject {
                userObject["first_name"] = self.firstNameLabel.text
                userObject["last_name"] = self.lastNameLabel.text
                userObject["email"] = self.emailLabel.text
                userObject["username"] = self.emailLabel.text
                userObject["biography"] = self.biographyTextField.text
                userObject["profile_image"] = PFFile(name: "profile_image.png", data: UIImagePNGRepresentation(self.profileImageView.image!)!)
                
                userObject.saveInBackground()

            }
        }
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true) {
            // after it is completed
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Do something with the images (based on your use case)
        profileImageView.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func updateInfo() {
        firstNameLabel.text = user.first_name
        lastNameLabel.text = user.last_name
        emailLabel.text = user.email
        biographyTextField.text = user.biography ?? ""
        user.profile_image.getDataInBackground(block: {
            (imageData: Data!, error: Error!) -> Void in
            if (error == nil) {
                self.profileImageView.image = UIImage(data:imageData)
                
            }
        })
    }
    
}
