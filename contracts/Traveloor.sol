//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Traveloor is ERC1155{
    using Counters for Counters.Counter;
    Counters.Counter private _flightIdCounter;
    Counters.Counter private _trainIdCounter;
    Counters.Counter private _cruiseIdCounter;
    Counters.Counter private _hotelIdCounter;
    Counters.Counter private _premiumIdCounter;

    uint maximumNumOfTickets;

    uint256 public constant FLIGHT = 0;
    uint256 public constant CRUISE = 1;
    uint256 public constant HOTEL = 2;
    uint256 public constant TRAIN = 3;
    uint256 public constant PREMIUM = 4;

    constructor(uint _maxTickets) ERC1155("ipfs://Qmf6c4FJWRULNTQ4dWZ2zDEqpB16DwFWQGcyynrAwM6tut") {
        maximumNumOfTickets = _maxTickets;
    }

    modifier checkPrice() {
        require(msg.value == 0.1 ether, "insufficient ether");
        _;
    }

    modifier ifExceeded(uint _value) {
        require(_value <= maximumNumOfTickets, "nft volume exceeded");
        _;
    }

    function checkPremium() internal returns(bool) {
        for (uint256 i = 0; i < 4; i++) {
            if(IERC1155(address(this)).balanceOf(msg.sender, i) >= 1){
                return true;
            }   
        }
    }

    function uri(uint collectionId, uint tokenId ) internal pure returns(string memory){
        return (
            string(
                abi.encodePacked("ipfs://Qmf6c4FJWRULNTQ4dWZ2zDEqpB16DwFWQGcyynrAwM6tut/",
                Strings.toString(collectionId),
                "/",
                Strings.toString(tokenId),
                ".json"
                )
            )
        ); 
    }

    function mintFlight() public checkPrice() payable ifExceeded(_flightIdCounter.current()){
        uint tokenId = _flightIdCounter.current();
        _flightIdCounter.increment();
        _setURI(uri(FLIGHT,tokenId));
        _mint(msg.sender, FLIGHT, 1,"");
    }

    function mintTrain() public checkPrice() payable ifExceeded(_trainIdCounter.current()){
        uint tokenId = _trainIdCounter.current();
        _trainIdCounter.increment();
        _setURI(uri(TRAIN,tokenId));
        _mint(msg.sender, TRAIN, 1,"");
    }

    function mintCruise() public checkPrice() payable ifExceeded(_cruiseIdCounter.current()){ 
        uint tokenId = _cruiseIdCounter.current();
        _cruiseIdCounter.increment();
        _setURI(uri(CRUISE,tokenId));
        _mint(msg.sender, CRUISE, 1,"");
    }

    function mintHotel() public checkPrice() payable ifExceeded(_hotelIdCounter.current()){
        uint tokenId = _hotelIdCounter.current();
        _hotelIdCounter.increment();
        _setURI(uri(HOTEL,tokenId));
        _mint(msg.sender, HOTEL, 1,"");
    }

    function mintPremium() public payable ifExceeded(_premiumIdCounter.current()){
        require(msg.value == 0.3 ether, "insufficient ether");
        require(checkPremium());
        uint tokenId = _premiumIdCounter.current();
        _premiumIdCounter.increment();
        _setURI(uri(PREMIUM,tokenId));
        _mint(msg.sender, PREMIUM, 1,"");
    }

}