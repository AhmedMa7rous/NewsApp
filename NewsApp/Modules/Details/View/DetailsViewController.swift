//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Adam on 09/05/2023.
//

import UIKit
import Cosmos

class DetailsViewController: UIViewController {

    //MARK: - Outlet Connections
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var articleDetailsLabel: UILabel!
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
/*=====================================================*/
    //MARK: - Properties
    private var viewModel: DetailsViewModel
    private var articleRate = ""
    
/*=====================================================*/
    //MARK: - LifeCycle
    
    init(article: Article) {
        self.viewModel = DetailsViewModel(with: article)
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateTextField.delegate = self
        updateUi()
        bindData()
    }
    
/*=====================================================*/
    //MARK: - Action Connections
    @IBAction func sourceButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: viewModel.article.url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        articleRate = rateTextField.text ?? ""
        guard let input = Int(articleRate) else { return }
        switch input {
        case 1...5:
            showAlert(for: .success)
            rateView.rating = Double(input)
        default:
            showAlert(for: .error)
        }
    }
    
/*=====================================================*/
    //MARK: - Services Functions
    ///This function responsible for every thing related with UI
    private func updateUi() {
        //Set up navigation bar UI
        navigationItem.title = "Article Details"
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.7044164538, green: 0.6086986661, blue: 0.5285223126, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    ///This function responsible for binging the data to UI components
    private func bindData() {
        articleTitleLabel.text = viewModel.article.title
        let url = viewModel.article.urlToImage ?? "apple"
        switch url {
        case "apple":
            articleImageView.image = UIImage(named: url)
        default:
            let imageUrl = URL(string: url)
            articleImageView.sd_setImage(with: imageUrl, completed: nil)
        }
        
        articleDateLabel.text = viewModel.article.publishedAt
        articleAuthorLabel.text = "By: " + (viewModel.article.author ?? "Unknown")
        articleDetailsLabel.text = viewModel.article.description + "\n\n\n" + viewModel.article.content
        
    }
    
    ///This function responsible for making alerts according to user input in text field
    private func showAlert(for state: State) {
        var alertMessege = ""
        var actionTitle = ""
        switch state {
        case .success:
            alertMessege = "Article rated successfully."
            actionTitle = "Ok"
        case .error:
            alertMessege = "Please enter value from 1 to 5 for rating."
            actionTitle = "Try Again"
        }
        let alert = UIAlertController(title: "Article Rating", message: alertMessege, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

/*=================================================================*/
    //MARK: - TextField Functions

extension DetailsViewController: UITextFieldDelegate {
    
    ///This function responsible for make rate textfield accept numbers only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
