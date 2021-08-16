//
//  BlogsViewController.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/16/21.
//

import UIKit

class BlogsViewController: UIViewController {

    @IBOutlet weak var blogsTableView: UITableView!
    private var todos: [Todo] = []
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        activityIndicator.startAnimating()
        
        let network = BlogNetworking()

        network.fetch(resource: "todos", model: Todo.self) { results in
            self.todos = results as! [Todo]
            self.activityIndicator.stopAnimating()
            self.blogsTableView.reloadData()
        }
    }
    
    fileprivate func setupActivityIndicator() {

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)

        let centerXconstraint = activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let centerYconstraint = activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)

        let constraints = [centerYconstraint, centerXconstraint]

        NSLayoutConstraint.activate(constraints)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let network = BlogNetworking()
        network.fetch(resource: "todos", model: Todo.self) { results in
            print(results)
        }
    }
}

extension BlogsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
        return cell
    }
}

//extension BlogsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        guard let navController = self.navigationController else {
//            return
//        }
//        
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let todo = todos[indexPath.row]
//        let detailViewController = mainStoryboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
//        detailViewController.todo = todo
//        
//        navController.pushViewController(detailViewController, animated: true)
//    }
//}
