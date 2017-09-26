//
//  AddNoteViewController.swift
//  NotesSwift
//
//  Created by Eugene Mekhedov on 26.09.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet var headerTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var textViewbottomConstraint: NSLayoutConstraint!
    
    var isKeyboardShown = false
    var toolForTextView : UIToolbar? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Keyboard
    @objc
    func keyboardWillHide(notification: Notification){
        let keyboardRect = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! CGRect
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration, animations: {[weak self] in
            self?.textViewbottomConstraint.constant -= keyboardRect.size.height + 40
        })
        self.isKeyboardShown = false
    }
    @objc
    func keyboardWillShow(notification: Notification){
        if !self.isKeyboardShown{
            let keyboardRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
            let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
                UIView.animate(withDuration: duration, animations: {[weak self] in
                    self?.createToolBar(withKeyboardRect: keyboardRect, andDuration: duration)
                    self?.textViewbottomConstraint.constant += keyboardRect.size.height + 40
                })
            self.isKeyboardShown = true
        }
    }
    //MARK: - TextView
    @objc
    func actionDoneTextView(sender:UIBarButtonItem){
        self.toolForTextView?.removeFromSuperview()
        self.toolForTextView = nil
        if self.descriptionTextView.isFirstResponder{
            self.descriptionTextView.resignFirstResponder()
        }else{
            self.headerTextField.resignFirstResponder()
        }
    }
    
    func createToolBar(withKeyboardRect keyboardRect: CGRect, andDuration duration: Double){
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.height, width: keyboardRect.width, height: 40))
        toolBar.barTintColor = .gray
        toolBar.tintColor = .white
        
        let doneBar = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(actionDoneTextView))
        let flexSpaceBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolBar.items = [flexSpaceBar, doneBar]
        
        self.toolForTextView = toolBar
        UIView.animate(withDuration: duration) {
            toolBar.frame = CGRect(x: 0, y: (keyboardRect.minY) - 40, width: keyboardRect.width, height: 40)

        }
        self.view.addSubview(toolBar)
    }

    //MARK: - UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Описание...")
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Описание..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    //MARK: Action
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        let newNote = Note(header: headerTextField.text ?? "", description: descriptionTextView.text)
        DataManager.sharedManager.addNewNote(note: newNote)
        navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
