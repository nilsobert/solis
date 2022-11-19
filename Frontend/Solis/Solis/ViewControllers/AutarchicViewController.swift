//
//  AutarchicViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 19.11.22.
//

import UIKit

class AutarchicViewController: UIViewController {

    @IBOutlet weak var tableBackView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var transitionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //corner radius
        tableBackView.clipsToBounds = true
        tableBackView.layer.cornerRadius = 36
        tableBackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        addTransitionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showTransitionView),
                                               name:Notification.Name("ADD_TRANSITIONVIEW"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeTransitionView),
                                               name:Notification.Name("REMOVE_TRANSITIONVIEW"),
                                               object: nil)
        
    }
    
    @objc func addTransitionView() {
        transitionView = UIView(frame: .zero)
        transitionView.translatesAutoresizingMaskIntoConstraints = false
        transitionView.backgroundColor = UIColor.init(red: 106/255, green: 106/255, blue: 106/255, alpha: 0.35)
        view.addSubview(transitionView)
        
        NSLayoutConstraint.activate([
            transitionView.topAnchor.constraint(equalTo: view.topAnchor),
            transitionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            transitionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            transitionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        transitionView.isHidden = true
    }
    
    @objc func removeTransitionView() {
        transitionView.isHidden = true
    }
    
    @objc func showTransitionView() {
        transitionView.isHidden = false
    }
    
}

extension AutarchicViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell", for: indexPath)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

