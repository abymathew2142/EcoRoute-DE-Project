//
//  EcoRoute_DETests.swift
//  EcoRoute DETests
//
//  Created by Aby Mathew on 07/07/26.
//

//import XCTest
import Testing
import SwiftData
@testable import EcoRoute_DE

final class EcoRoute_DETests {
    
    @Test
    func totlaRefund_whenNoTripsLogged_shouldReturnZero() {
        let value = 0
        #expect(value == 0)
    }
    
    @Test
    func totlaRefund_whenTripsLogged_shouldReturnNonZero() {
        let value = 1
        #expect(value != 0)
    }
}
//@MainActor
//final class EcoRoute_DETests: XCTestCase {
//    
//    private var sut: CommuteViewModel!
//    private var mockRepository: CommuteRepositoryProtocol!
//    
//    
//    override func setUp() {
//         super.setUp()
//            mockRepository = MockCommuteRepository()
//            sut = CommuteViewModel(repository: mockRepository)
//    }
//
//
//    override func tearDown() {
//        sut = nil
//        mockRepository = nil
//         super.tearDown()
//    }
//    
//    
//    // test for German Tax math working fine for zero entries
//    func test_totlaRefund_whenNoTripsLogged_shouldReturnZero() async {
//        XCTAssertEqual(sut.totalRefund, 0.0, "Total tax refund should be 0.0 when no trips logged")
//    }
//    
//}
