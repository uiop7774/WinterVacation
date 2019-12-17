//
//  PullToRefresh.swift
//  RefreshableList_ver2
//
//  Created by James on 2019/12/17.
//  Copyright © 2019 James. All rights reserved.
//

import Foundation
import SwiftUI

struct PullToRefresh: UIViewRepresentable{
    
    
    @State var needRefresh = false
    
    class Coordinator: NSObject, UIScrollViewDelegate{
        
        var control: PullToRefresh
        
        init(_ control: PullToRefresh) {
            self.control = control
        }
        
        func listViewDidScroll(_ scrollView: UIScrollView) {
            print("sucesss")
        }
        
        @objc func handleRefresh(sender: UIRefreshControl){
            print("done")
            sender.endRefreshing()
        }
        
    }
     
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
        
    func makeUIView(context: UIViewRepresentableContext<PullToRefresh>) -> UIView {
        
        let control = UITableView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        
        
        print("in makeUIView")
        return UIView(frame: .zero)
        
    }
    
    
    func tableView(root: UIView) -> UITableView? {
        for subview in root.subviews {
            if let tableView = subview as? UITableView {
                return tableView
            } else if let tableView = tableView(root: subview) {
                return tableView
            }
        }
        return nil
    }

    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PullToRefresh>) {
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard let viewHost = uiView.superview?.superview else {
                return
            }
            guard let tableView = self.tableView(root: viewHost) else {
                return
            }
            
            if let refreshControl = tableView.refreshControl {
                if self.needRefresh {
                    refreshControl.beginRefreshing()
                    self.needRefresh = false
                } else {
                    refreshControl.endRefreshing()
                    self.needRefresh = true
                }
                return
            }
        }
        /*
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        */
        print("in updateUIView")
        
        
    }
}

