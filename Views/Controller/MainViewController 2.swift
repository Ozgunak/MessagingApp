//
//  MainViewController.swift
//  Views
//
//  Created by ozgun on 13.01.2022.
//

import UIKit
import Firebase


class MainViewController: UIViewController  {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentTextLabel: UITextField!
    
    let db = Firestore.firestore()
    
    var contents: [Content] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadContent()
    }
    
    func loadContent() {
        db.collection(K.collectionName).order(by: K.dateField).addSnapshotListener { (querySnapshot, err) in
            self.contents = []

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    let data = doc.data()
                    if let sender = data[K.senderField] as? String, let body = data[K.bodyField] as? String {
                        
                        let content = Content(sender: sender,  contentBody: body)
                        self.contents.append(content)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        // Add a new document with a generated ID
        if let contentBody = contentTextLabel.text, let email = Auth.auth().currentUser?.email {
            
            var ref: DocumentReference? = nil
            ref = db.collection(K.collectionName).addDocument(data: [K.senderField: email,
                                                                     K.bodyField: contentBody,
                                                                     K.dateField: Date.timeIntervalSinceReferenceDate]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                        print("Document added with ID: \(ref!.documentID)")
                    
                }
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            self.navigationController!.popToRootViewController(animated: true)
            print("Succesfully logged out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! ContentCell
        
        
        cell.contentLabel.text = contents[indexPath.row].contentBody
        return cell
    }
    
    
}
