//
//  HomePresenterTests.swift
//  YouTubeCloneTests
//
//  Created by ENMANUEL TORRES on 2/02/23.
//

import XCTest
@testable import YouTubeClone

final class HomePresenterTests: XCTestCase {
    
    var sut: HomePresenter!
    var sutDelegate: homeViewMock!
    var provider: HomeProviderMock!

    @MainActor override func setUpWithError() throws {
       MockManager.shared.runAppwithMock = true
       sutDelegate = homeViewMock()
       provider = HomeProviderMock()
       sut = HomePresenter(delegate: sutDelegate, provider: provider)
    }

    override func tearDownWithError() throws {
       sut = nil
       provider = nil
       sutDelegate = nil
    }

    func testGetHomeObject_WhenLoad_ObjectsShoutBeInCorrctPosition() async throws {
        
       await sut.getHomeObjcts()
        
        
        XCTAssertTrue(sutDelegate.objectList![0] is [ChannelModel.Items], "this first position should be of type ChannelModel.Items")
        XCTAssertTrue(sutDelegate.objectList![1] is [PlaylistitemsModel.Item], "this second position should be of type PlaylistitemsModel.Item")
        XCTAssertTrue(sutDelegate.objectList![2] is [VideoModel.Item], "this thirsd position should be of type VideoModel.Item")
        XCTAssertTrue(sutDelegate.objectList![3] is [PlaylistModel.Item], "this fourts position should be of type PlaylistModel.Item")
    }
    func testGetHomeObject_WhenLoad_SectionTitlesShouldBeCorrect() async throws {
       let expectSectionTitle0 = ""
        let expectSectionTitle1 = "Curso de Swift Español - Clonando YouTube"
        let expectSectionTitle2 = "Uploads"
        let expectSectionTitle3 = "Created Playlists"
        
       await sut.getHomeObjcts()
        
        XCTAssertEqual(sutDelegate.sectionTitleList![0], expectSectionTitle0)
        XCTAssertEqual(sutDelegate.sectionTitleList![1], expectSectionTitle1)
        XCTAssertEqual(sutDelegate.sectionTitleList![2], expectSectionTitle2)
        XCTAssertEqual(sutDelegate.sectionTitleList![3], expectSectionTitle3)
        
        
      
    }
    @MainActor
    func testGetHomeObject_WhenLoad_ShouldFail() async throws {
        //Arrange
        MockManager.shared.runAppwithMock = false
        sutDelegate = homeViewMock()
        provider = HomeProviderMock()
        provider.throwError = true
        sut = HomePresenter(delegate: sutDelegate, provider: provider)
        
        //Act
       await sut.getHomeObjcts()
        
        //Assert
        XCTAssertTrue(sutDelegate.throwError)
     
    }

}

class homeViewMock : HomeViewProtocol{
    var objectList : [[Any]]?
    var sectionTitleList : [String]?
    var throwError : Bool = false
    
    func getData(list: [[Any]], sectionTitleList: [String]) {
        objectList = list
        self.sectionTitleList = sectionTitleList
    }
    
    func loadingView(_ state: YouTubeClone.LoadingViewState) {
        
    }
    
    func showError(_ error: String, callback: (() -> Void)?) {
        throwError = true
    }
    
           
}
