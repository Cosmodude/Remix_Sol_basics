// SPDX-license-Identifier: MIT

pragma solidity >= 0.6.6 < 0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
contract Fundme{

    mapping (address => uint256) public addrToamount;

    function Fund() public payable {
            addrToamount[msg.sender]+= msg.value;
            // What is the exchange rate?
    }
    function GetVersion() public view returns (uint256)
    {
        AggregatorV3Interface PriceFeed =  AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return PriceFeed.version();
    }
    function GetPrice() public view returns(uint256)
    {
        AggregatorV3Interface PriceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (   ,
            int price,,,) =PriceFeed.latestRoundData();
        return uint256(price*10**10);
    }
}