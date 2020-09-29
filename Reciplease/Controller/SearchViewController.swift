//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 21/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var ingredients: [String] = []

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientListeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        ingredientListeTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesVC = segue.destination as? RecipesViewController else {
            return
        }
        recipesVC.ingredients = ingredients
    }

    @IBAction func tappedAddIngredientButton() {
        guard ingredientTextField.text != nil, ingredientTextField.text != "" else {
            textIsEmptyAlerte()
            return }
        addIngredient(for: ingredientTextField.text ?? "")
        ingredientTextField.text = ""
    }

    @IBAction func tappedClearButton(_ sender: Any) {
        ingredients.removeAll()
        ingredientTextField.text = ""
        ingredientListeTableView.reloadData()
    }

    private func addIngredient(for ingredient: String) {
        ingredients.append(ingredient)
        ingredientListeTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate {

}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)

        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = " - \(ingredient)"

        return cell
    }
}

//MARK: Alerte
extension SearchViewController {

    private func textIsEmptyAlerte() {
        let alerte = UIAlertController(title: "Empty Ingredient Field", message: "please enter an ingredient ", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte, animated: true, completion: nil)
    }
}

//MARK: Keyboard
extension SearchViewController {

    @IBAction func dismissKeyboard(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }
}
