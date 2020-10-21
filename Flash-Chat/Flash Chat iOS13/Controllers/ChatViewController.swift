//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    var messages:[Message] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = K.titleLable
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        messageTextfield.delegate = self
        loadData()
        
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        
        if  messageTextfield.text != "" {
            sendData()
            messageTextfield.text=""
        }
        else {
            messageTextfield.placeholder = "Write some thing"
            
        }
        
    }
    
    func loadData()  {
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapShot, error) in
            if let e = error {print("There was an issue \(e)")}
            else{
                self.messages.removeAll()
                if let documents = querySnapShot?.documents {
                    for document in documents {
                        let data = document.data()
                        if let senderMessage = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            
                            let message = Message(sender: senderMessage, text: messageBody)
                            self.messages.append(message)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
        }
    }
    
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    
    func sendData() {
        
        let date = Date().timeIntervalSince1970
        
        if let messageSender = Auth.auth().currentUser?.email, let messageBody = messageTextfield.text{
            
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:messageSender,
                                                                      K.FStore.bodyField:messageBody,
                                                                      K.FStore.dateField:date])
            { (error) in
                if let e = error {print("Error \(e)")}
                else {print("Succeed")}
            }
            
        }
        
    }
    
}

extension ChatViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
            as! MessageCell
        cell.cellLable.text = messages[indexPath.row].text
        let messageSender = messages[indexPath.row].sender
        
        let userName = Auth.auth().currentUser?.email
        print (userName == messageSender)
        if userName !=  messageSender{
            
            cell.rightImage.isHidden = true
            cell.leftImage.isHidden = false
            cell.cellView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            
        }else{
            
            cell.rightImage.isHidden = false
            cell.leftImage.isHidden = true
            cell.cellView.backgroundColor = UIColor(named: K.BrandColors.purple)
            
        }
        return cell
    }
    
}
