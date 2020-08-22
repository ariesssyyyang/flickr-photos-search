//
//  ResultListController.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ResultListController: UIViewController {

    private let viewModel: ResultListViewModel

    private let bag = DisposeBag()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = MARGIN
        layout.minimumLineSpacing = MARGIN
        layout.sectionInset = UIEdgeInsets(
            top: MARGIN, left: MARGIN, bottom: MARGIN, right: MARGIN
        )
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let refreshControl = UIRefreshControl()

    init(viewModel: ResultListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getResult()
        binding()
    }
}

extension ResultListController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.results.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath)
        cell.bind(viewModel.cellViewModel(at: indexPath.item))
        return cell
    }
}

extension ResultListController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.bounds.size.width - MARGIN * 3) / 2)
        return CGSize(
            width: width,
            height: width + MARGIN + PhotoCell.LABEL_HEIGHT
        )
    }
}

private extension ResultListController {

    func binding() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in self?.getResult() })
            .disposed(by: bag)
    }

    func getResult() {
        viewModel.getResult()
            .subscribe(onNext: { [weak self] in self?.reload() })
            .disposed(by: bag)
    }

    func reload() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.collectionView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }

    func setupView() {
        title = "搜尋結果 " + viewModel.keyword
        view.addSubview(collectionView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        collectionView.refreshControl = refreshControl
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
