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

class EditProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UINavigationBarDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var user = UserAccount.current()!
    var userAccountInfoCell: EditProfileCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        navigationBar.delegate = self
        
        user = try! UserAccount.current()!.fetch()

    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "EditProfileCell") as! EditProfileCell
        userAccountInfoCell = cell
        
        // tap to edit profile view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cell.profileImageView.isUserInteractionEnabled = true
        cell.profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        cell.firstNameLabel.text = user.first_name
        cell.lastNameLabel.text = user.last_name
        cell.emailLabel.text = user.email
        cell.biographyTextField.text = user.biography ?? ""
        cell.cityLabel.text = user.city
        cell.currentPositionLabel.text = user.current_position
        user.profile_image.getDataInBackground(block: {
            (imageData: Data!, error: Error!) -> Void in
            if (error == nil) {
                cell.profileImageView.image = UIImage(data:imageData)
                
            }
        })
        return cell
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
        userAccountInfoCell?.profileImageView.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func saveButton(_ sender: Any) {
        let query = PFQuery(className:"_User")
        let cell = userAccountInfoCell!
        query.getObjectInBackground(withId: user.objectId!) {
            (userObject: PFObject?, error: Error?) -> Void in
            if error != nil {
                print(error ?? "crap")
            } else if let userObject = userObject {
                userObject["first_name"] = cell.firstNameLabel.text
                userObject["last_name"] = cell.lastNameLabel.text
                userObject["email"] = cell.emailLabel.text
                userObject["username"] = cell.emailLabel.text
                userObject["biography"] = cell.biographyTextField.text
                userObject["city"] = cell.cityLabel.text
                userObject["current_position"] = cell.currentPositionLabel.text
                userObject["profile_image"] = PFFile(name: "profile_image.png", data: UIImagePNGRepresentation(cell.profileImageView.image!)!)
                
                userObject.saveInBackground()

            }
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // UI custom navigation bar auto correct for status bar
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    
}
