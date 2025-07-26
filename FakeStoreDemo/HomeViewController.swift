//
//  HomeViewController.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageData = ["mario1", "mario2", "mario3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerCells()
        collectionView.collectionViewLayout = generateLayout()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: "BannerCVCell", bundle: nil), forCellWithReuseIdentifier: BannerCVCell.identifier)

    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return UICollectionViewCompositionalLayout(section: section)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVCell.identifier, for: indexPath) as! BannerCVCell
        cell.imageView.image = UIImage(named: imageData[indexPath.item])
        return cell
    }
    
    
}
