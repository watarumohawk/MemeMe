//
//  MemeEditorViewController
//  MemeMe
//
//  Created by Wataru on 2016/06/15.
//  Copyright © 2016年 Wataru Sekiguchi. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    
    @IBOutlet weak var toolBarTop: UIToolbar!
    @IBOutlet weak var toolBarBottom: UIToolbar!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextField(textFieldTop)
        setUpTextField(textFieldBottom)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribToKeyboardNotifications()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        shareButton.enabled = (imagePickerView.image == nil) ? false : true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsbscribeFromKeyboadNotifications()
    
    }
    
    @IBAction func pickAnFromAlbum(sender: AnyObject) {

        selectPhotoType(.PhotoLibrary)
        
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {

        selectPhotoType(.Camera)
        
    }

    @IBAction func shareMeme(sender: AnyObject) {
    
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)

        activityViewController.completionWithItemsHandler = { activity, success, items, error in

            if (success == true) {
                
                //Generate a memed image
                self.save(memedImage)

                //Dismiss
                self.dismissViewControllerAnimated(true, completion: nil)
            }

        }
    
        presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        let tableViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TableViewController")
        
        navigationController?.presentViewController(tableViewController, animated: true,completion:nil)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func selectPhotoType(source: UIImagePickerControllerSourceType) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func setUpTextField (textField: UITextField) {
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
        textFieldTop.text = "TOP"
        textFieldBottom.text = "BOTTOM"
        textField.delegate = self
        
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
    
    func subscribToKeyboardNotifications() {
    
        //  Keyboard show
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        // Keyboad hide
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsbscribeFromKeyboadNotifications() {
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    // move the screen up to prvent keyboard overlap
    func keyboardWillShow(notification: NSNotification) {
        
        // Only bottom
        if textFieldBottom.isFirstResponder() {
            
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
            
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.CGRectValue().height
        
    }
    
    // move back the keyboard after using
    func keyboardWillHide(notification: NSNotification) {
        
        // Only bottom
        if textFieldBottom.isFirstResponder() {
        
            view.frame.origin.y = 0
            
        }
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {

        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }

    // when Retun key is typed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide keyboard
        view.endEditing(true)
        
        return true
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        toolBarTop.hidden = true
        toolBarBottom.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        toolBarTop.hidden = false
        toolBarBottom.hidden = false
        
        return memedImage
        
    }
    
    func save(memedImage: UIImage) {
        //Create the meme
        let meme = Meme(topText: textFieldTop.text, bottomText: textFieldBottom.text, image:
            imagePickerView.image, memedImage: memedImage)

        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
}
