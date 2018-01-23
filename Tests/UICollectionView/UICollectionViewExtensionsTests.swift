//
//  UICollectionViewExtensionsTests.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - UICollectionViewExtensionsTests

//import UIKit
//import XCTest
//
//@testable import TinyKit
//
//final class UICollectionViewExtensionsTests: XCTestCase {
//
//    // MARK: Component
//
//    enum Component: Int {
//
//        case noNibCell
//
//        case nibCell
//
//    }
//
//    // MARK: Property
//
//    final var components: [Component]?
//
//    final var collectionView: UICollectionView?
//
//    // MARK: Set Up
//
//    final override func setUp() {
//        super.setUp()
//
//        components = [ .noNibCell, .nibCell ]
//
//        collectionView = UICollectionView(
//            frame: .zero,
//            collectionViewLayout: UICollectionViewFlowLayout()
//        )
//
//        collectionView!.dataSource = self
//
//    }
//
//    final override func tearDown() {
//
//        components = nil
//
//        collectionView = nil
//
//        super.tearDown()
//    }
//
//    // MARK: Register Cells
//
//    final func testRegisterCellWithoutNib() {
//
//        collectionView!.registerCell(
//            NoNibCollectionViewCell.self
//        )
//
//        let index = components!.index(of: .noNibCell)!
//
//        let section = components![index].rawValue
//
//        let cell = collectionView?.dequeueReusableCell(
//            withReuseIdentifier: "NoNibCollectionViewCell",
//            for: IndexPath(item: 0, section: section)
//        ) as? NoNibCollectionViewCell
//
//        XCTAssertNotNil(cell)
//
//    }
//
//    final func testRegisterCellWithNib() {
//
//        collectionView!.registerCell(
//            NibCollectionViewCell.self,
//            withNibFrom: Bundle(for: classForCoder)
//        )
//
//        let index = components!.index(of: .nibCell)!
//
//        let section = components![index].rawValue
//
//        let cell = collectionView?.dequeueReusableCell(
//            withReuseIdentifier: "NibCollectionViewCell",
//            for: IndexPath(item: 0, section: section)
//        ) as? NibCollectionViewCell
//
//        XCTAssertNotNil(cell)
//
//    }
//
//    // MARK: Dequeue Reusable Cells
//
//    final func testDequeueReusableCell() {
//
//        collectionView!.registerCell(
//            NoNibCollectionViewCell.self
//        )
//
//        let index = components!.index(of: .nibCell)!
//
//        let section = components![index].rawValue
//
//        let cell = collectionView!.dequeueReusableCell(
//            NoNibCollectionViewCell.self,
//            for: IndexPath(item: 0, section: section)
//        )
//
//        XCTAssertNotNil(cell)
//
//    }
//
//}
//
//// MARK: - UICollectionViewDataSource
//
//extension UICollectionViewExtensionsTests: UICollectionViewDataSource {
//
//    final func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//        return components!.count
//
//    }
//
//    final func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return 1
//
//    }
//
//    final func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let component = Component(rawValue: indexPath.section)!
//
//        switch component {
//
//        case .noNibCell:
//
//            let identifier = NoNibTableViewCell.identifier
//
//            return collectionView.dequeueReusableCell(
//                withReuseIdentifier: identifier,
//                for: indexPath
//            )
//
//        case .nibCell:
//
//            let identifier = NibCollectionViewCell.identifier
//
//            return collectionView.dequeueReusableCell(
//                withReuseIdentifier: identifier,
//                for: indexPath
//            )
//
//        }
//
//    }
//
//}
