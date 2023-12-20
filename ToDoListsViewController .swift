//
//  ToDoListsViewController.swift
//  ToDoist
//
//  Created by shark boy on 12/13/23.
//

import UIKit

class ToDoListsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let itemManager = ItemManager.shared
    var toDoLists = [ToDoList]()
//
//    init(itemManager: ItemManager, toDoLists: ToDoList) {
//        self.toDoLists = itemManager.fetchToDoLists(matching: NSPredicate(format: "ToDoList"))
//        super .init(coder: coder)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBOutlet weak var toDoTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        toDoLists = itemManager.fetchToDoLists(matching: NSPredicate(format: "name == %@", "ToDoList"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addToDoListTapped(_ sender: Any) {
        
        showInputDialog(nil)
    
    }
    
    @IBSegueAction func toDoListTapped(_ coder: NSCoder, sender: Any?) -> ItemsViewController? {
        return ItemsViewController(coder: coder)
    }


    
}


extension ToDoListsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        let item = toDoLists[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let itemsVC = segue.destination as? ItemsViewController {
            let selectedToDoList = toDoLists[indexPath.row]
            itemsVC.toDoList = selectedToDoList
        }
    }

    
}

extension ToDoListsViewController {

    func showInputDialog(_ placeholder: String?) {
        let alert = UIAlertController(title: "Enter Text", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            
            textField.keyboardType = .default
            textField.returnKeyType = .done
            
        }
        
        alert.addAction(UIAlertAction(title: "enter", style: .default, handler: { _ in
            // Accessing the text field's value
            if let textField = alert.textFields?.first, let textValue = textField.text, !textValue.isEmpty {
             // check if toDoLists array contains an instance with the same name, if not instantiate a new toDoList and add it to the toDoLists array
                self.itemManager.createNewToDoList(with: textValue)
                self.toDoLists = self.itemManager.fetchToDoLists(matching: NSPredicate(format: "name == %@", "ToDoList"))
                self.tableView.reloadData()
            }
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
}
