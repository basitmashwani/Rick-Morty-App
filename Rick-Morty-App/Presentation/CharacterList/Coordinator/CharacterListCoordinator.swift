//
//  CharacterListCoordinator.swift
//  Rick-Morty-App
//
//  Created by SyedAbdulBasit on 05/02/2022.
//
import UIKit

protocol CharacterListCoordinatorDependencies {
    func makeCharacterListViewController() -> CharacterListViewController
    func makeCharacterDetailDIContainer(character: Character) -> CharacterDetailDIContainer
}

final class CharacterListCoordinator: BaseCoordinator {
    // MARK: - Properties
    let dependencies: CharacterListCoordinatorDependencies
    private weak var parent: UINavigationController?
    // MARK: - Initializer
    ///  Initialize CharacterListCoordinatorDependencies & UINavigationController
    ///  - Parameter CharacterListCoordinatorDependencies
    ///  - Parameter UINavigationController
    init(dependencies: CharacterListCoordinatorDependencies, parent: UINavigationController) {
        self.dependencies = dependencies
        self.parent = parent
      //  dependencies.did
    }
    // MARK: - Coordinator
    /// Initiates the CharacterListView Controller and Display it
    override func start() {
        let recipeVC = dependencies.makeCharacterListViewController()
        recipeVC.itemSelected = { character in
            self.navigateToDetailScreen(with: character)
        }
        parent?.pushViewController(recipeVC, animated: true)
    }
    
    private func navigateToDetailScreen(with character: Character) {
        let characterDetailDIContainer = dependencies.makeCharacterDetailDIContainer(character: character)
        let coordinator = characterDetailDIContainer.characterDetailCoordinator(navigation: parent!)
        coordinator.start()

    }
}
