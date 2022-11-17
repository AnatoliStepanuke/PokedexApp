import XCTest
@testable import PokemonApp

final class PokemonAppTests: XCTestCase {

    private var networkManager: TestNetwork?

    override func setUpWithError() throws {
        networkManager = TestNetwork()
    }

    override func tearDownWithError() throws {
        networkManager = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        XCTAssertNoThrow(networkManager?.getPokemonList { result in
            print(result)
        })

        XCTAssertNotNil(networkManager?.getPokemonDetails(pokemonId: 1) { result in
            print(result)
        })
    }

    func testPerformanceExample() throws {
        measure(
            metrics: [
                XCTClockMetric(),
                XCTCPUMetric(),
                XCTStorageMetric(),
                XCTMemoryMetric()
            ]
        ) {
            networkManager?.getPokemonList { result in
                print(result)
            }

            networkManager?.getPokemonDetails(pokemonId: 1) { result in
                print(result)
            }
        }
    }
}
