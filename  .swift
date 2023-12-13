//
//  ToDoListsViewController.swift
//  ToDoist
//
//  Created by shark boy on 12/13/23.
//

import UIKit

class ToDoListsViewController: UIViewController {

    @IBOutlet weak var toDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addToDoListTapped(_ sender: Any) {
        
        showInputDialog(nil)
    
    }
    
}


extension ToDoListsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension ToDoListsViewController {
    func showInputDialog(_ placeholder: String?) {
        let alert = UIAlertController()
        alert.addTextField { (textField:UITextField) in
            textField.keyboardType = UIKeyboardType.default
        }


        self.present(alert, animated: true, completion: nil)
    }
}
