//
//  ViewController.swift
//  MemeMe
//
//  Created by Wataru on 2016/06/15.
//  Copyright © 2016年 Wataru Sekiguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
   
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextField("TOP")
        setUpTextField("BOTTOM")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribToKeyboardNotifications()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsbscribeFromKeyboadNotifications()
    
    }
    
    @IBAction func pickAnFromAlbum(sender: AnyObject) {
        
        selectPhotoType("PhotoLibrary")
        
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {

        selectPhotoType("Camera")
        
    }
    
    func selectPhotoType(type: String) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        type == "Camera" ? (imagePicker.sourceType = UIImagePickerControllerSourceType.Camera) : (imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary)
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func setUpTextField (place: String) {
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        
        if (place == "TOP") {
            
            textFieldTop.defaultTextAttributes = memeTextAttributes
            textFieldTop.textAlignment = NSTextAlignment.Center
            textFieldTop.text = "TOP"
            
        } else {
            
            textFieldBottom.defaultTextAttributes = memeTextAttributes
            textFieldBottom.textAlignment = NSTextAlignment.Center
            textFieldBottom.text = "BOTTOM"
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
            imagePickerView.image = image
                
        }
            
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    func keyboardWillShow(notification: NSNotification) {
        
        // Bottom だけにする
        view.frame.origin.y -= getKeyboardHeight(notification)
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        view.frame.origin.y = 0
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.CGRectValue().height
        
    }
    
    func subscribToKeyboardNotifications() {
    
        //  Keyboard show
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        // Keyboad hide
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsbscribeFromKeyboadNotifications() {
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
    }

    // when Retun key is typed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
//        textFieldTop.resignFirstResponder()
//        textFieldBottom.resignFirstResponder()
        textField.resignFirstResponder()
        
        return true
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar       
        
        return memedImage
    }
    
//    func save() {
//        //Create the meme
//        let meme = Meme( text: textField.text!, image:
//            imageView.image, memedImage: memedImage)
//    }
//    

}










