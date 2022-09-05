//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Traveloor is ERC1155 {
    using Counters for Counters.Counter;
    Counters.Counter private _flightIdCounter;
    Counters.Counter private _trainIdCounter;
    Counters.Counter private _cruiseIdCounter;
    Counters.Counter private _hotelIdCounter;
    Counters.Counter private _premiumIdCounter;

    uint256 maximumNumOfTickets;

    uint256 public constant FLIGHT = 0;
    uint256 public constant CRUISE = 1;
    uint256 public constant HOTEL = 2;
    uint256 public constant TRAIN = 3;
    uint256 public constant PREMIUM = 4;

    mapping(uint256 => string) private _uris;

    constructor(uint256 _maxTickets)
        ERC1155("ipfs://Qmf6c4FJWRULNTQ4dWZ2zDEqpB16DwFWQGcyynrAwM6tut")
    {
        maximumNumOfTickets = _maxTickets;
    }

    modifier checkPrice() {
        require(msg.value == 0.1 ether, "insufficient ether");
        _;
    }

    modifier ifExceeded(uint256 _value) {
        require(_value <= maximumNumOfTickets, "nft volume exceeded");
        _;
    }

    function checkPremium() internal view returns (bool) {
        for (uint256 i = 0; i < 4; i++) {
            if (balanceOf(msg.sender, i) >= 1) {
                return true;
            }
        }
    }

    /**
     * @dev sets uri for Token with collectionID in the format baseUri(uriHash)/_id.json
     *
     */
    function createTokenUri(uint256 collectionId)
        internal
        pure
        returns (string memory)
    {
        return (
            string(
                abi.encodePacked(
                    "ipfs://Qmf6c4FJWRULNTQ4dWZ2zDEqpB16DwFWQGcyynrAwM6tut/",
                    Strings.toString(collectionId),
                    ".json"
                )
            )
        );
    }

    /**
     * @dev allow users to mint a flight ticket
     * @notice ticket's availability is checked
     */
    function mintFlight()
        public
        payable
        checkPrice
        ifExceeded(_flightIdCounter.current())
    {
        _flightIdCounter.increment();
        if (bytes(_uris[FLIGHT]).length == 0) {
            _uris[FLIGHT] = createTokenUri(FLIGHT);
        }
        _mint(msg.sender, FLIGHT, 1, "");
    }

    /**
     * @dev allow users to mint a Train ticket
     *  @notice ticket's availability is checked
     */
    function mintTrain()
        public
        payable
        checkPrice
        ifExceeded(_trainIdCounter.current())
    {
        _trainIdCounter.increment();
        if (bytes(_uris[TRAIN]).length == 0) {
            _uris[TRAIN] = createTokenUri(TRAIN);
        }
        _mint(msg.sender, TRAIN, 1, "");
    }

    /**
     * @dev allow users to mint a cruise ticket
     *  @notice ticket's availability is checked
     */
    function mintCruise()
        public
        payable
        checkPrice
        ifExceeded(_cruiseIdCounter.current())
    {
        _cruiseIdCounter.increment();

        if (bytes(_uris[CRUISE]).length == 0) {
            _uris[CRUISE] = createTokenUri(CRUISE);
        }
        _mint(msg.sender, CRUISE, 1, "");
    }

    /**
     * @dev allow users to mint/book hotel
     *  @notice ticket's availability is checked
     */
    function mintHotel()
        public
        payable
        checkPrice
        ifExceeded(_hotelIdCounter.current())
    {
        _hotelIdCounter.increment();

        if (bytes(_uris[HOTEL]).length == 0) {
            _uris[HOTEL] = createTokenUri(HOTEL);
        }
        _mint(msg.sender, HOTEL, 1, "");
    }

    function mintPremium()
        public
        payable
        ifExceeded(_premiumIdCounter.current())
    {
        require(msg.value == 0.3 ether, "insufficient ether");
        require(checkPremium());
        _premiumIdCounter.increment();
        if (bytes(_uris[PREMIUM]).length == 0) {
            _uris[PREMIUM] = createTokenUri(PREMIUM);
        }
        _mint(msg.sender, PREMIUM, 1, "");
    }

    /**
     * @dev returns the uri for token with type _id
     This have been overriden to return the specific uri for each token type instead of the baseUri
    */
    function uri(uint256 _id)
        public
        view
        virtual
        override(ERC1155)
        returns (string memory)
    {
        return _uris[_id];
    }
}
