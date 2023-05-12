//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Adam on 09/05/2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak private var viewMessage: UIView!
    @IBOutlet weak private var lblMessage: UILabel!
    @IBOutlet weak private var imgMeessage: UIImageView!
    
/*=============================================*/
    //MARK: - Properties
    private var viewModel = HomeViewModel()
    
/*=============================================*/
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        viewModel.fetchData()
        bindTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.newsTableView.indexPathForSelectedRow {
            self.newsTableView.deselectRow(at: index, animated: true)
        }
        
    }

/*===========================================*/
    //MARK: - Action Connections
    
    
/*==========================================*/
    //MARK: - Services Functions
    ///This function responsible for every thing related with UI
    private func updateUi() {
        setupIntialView()
        setUpNavigationBar()
        setupTableView()
        setupObservables()
    }
    
    ///This is a support function (support updateUi function) to set up navigation bar UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setUpNavigationBar() {
        navigationItem.title = "Apple News"
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.7044164538, green: 0.6086986661, blue: 0.5285223126, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    ///This is a support function (support updateUi function) to set up initial state for  UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupIntialView() {
        //Set Intial state
        navigationController?.navigationBar.isHidden = true
        newsTableView.isHidden = true
        viewMessage.isHidden = false
        lblMessage.text = "Getting News..."
        imgMeessage.image = #imageLiteral(resourceName: "Loading")
    }
    
    ///This is a support function (support updateUi function) to register a cell for TableView UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupTableView() {
        newsTableView.separatorStyle = .none
        //Register PlayersCell
        newsTableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
    ///This is a support function (support updateUi function) to change UI according to data network call
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupObservables() {
        //Set success state
        viewModel.onSuccess.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.viewMessage.isHidden = true
            self.navigationController?.navigationBar.isHidden = false
            self.newsTableView.isHidden = false
    }.disposed(by: viewModel.disposeBag)
                
        //Set error state
        viewModel.onError.subscribe { [weak self] error in
            guard let self = self else { return }
            self.newsTableView.isHidden = true
            self.viewMessage.isHidden = false
            self.navigationController?.navigationBar.isHidden = true
            self.lblMessage.text = "Oops! something wrong try again later!!"
            self.imgMeessage.image = #imageLiteral(resourceName: "Error")
        }.disposed(by: viewModel.disposeBag)
    }
}

/*====================================================================*/
extension HomeViewController: UITableViewDelegate {
    //MARK: - Players TableView Functions
     func bindTableView() {
         newsTableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
         viewModel.news.bind(to: newsTableView.rx.items(cellIdentifier: HomeTableViewCell.identifier, cellType: HomeTableViewCell.self)) { (row, item, cell) in
             cell.configure(article: item)

         } .disposed(by: viewModel.disposeBag)
         
         newsTableView.rx.modelSelected(Article.self).subscribe { [weak self] item in
             guard let self = self else { return }
             guard let article = item.element else { return }
             let vc = DetailsViewController(article: article)
             self.navigationController?.pushViewController(vc, animated: true)
         }.disposed(by: viewModel.disposeBag)
         
//         newsTableView.rx.modelDeselected(Article.self).subscribe { item in
//             print("deselected: \(item)")
//         }.disposed(by: viewModel.disposeBag)
     }
}
