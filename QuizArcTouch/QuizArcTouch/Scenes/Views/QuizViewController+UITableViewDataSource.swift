//
//  QuizViewController+TableViewDataSource.swift
//  QuizArcTouch
//
//  Created by Débora Oliveira on 17/11/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)

        let cellViewModel = quizViewModel.getCellViewModel(for: indexPath)
        cell.textLabel?.text = cellViewModel?.keywordText

        return cell
    }
}
