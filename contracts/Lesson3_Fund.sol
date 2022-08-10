// SPDX-license-Identifier: MIT

pragma solidity >= 0.6.6 < 0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
contract Fundme{
    using SafeMathChainlink for uint256;

    mapping (address => uint256) public addrToamount;

    address public owner;
    constructor() public {
        owner= msg.sender;
    }

    modifier OnlyOwner {
        require(msg.sender==owner,"wrong person");
        _;
    }

    address[] public Funders;
    function Fund() public payable {
            uint256 min =5 *10**18;
            /*if (msg.value < min){
                revert();
            }*/
            require(GetConversionRate(msg.value) >= min, "Send more");
            addrToamount[msg.sender]+= msg.value;
            Funders.push(msg.sender);
            // What is the exchange rate?
    }

    function Withdraw() public payable OnlyOwner {
        msg.sender.transfer(address(this).balance);
        for (uint256 index=0; index<Funders.length; index++)
        {addrToamount[Funders[index]]=0;}
        Funders=new address[](0);
    }

    function GetPrice() public view returns(uint256)
    {
        AggregatorV3Interface PriceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (   ,
            int price,,,) =PriceFeed.latestRoundData();
        return uint256(price*10**10);
    }

    function GetConversionRate(uint256 ETH) public view returns(uint256) {
        uint256 ETHPrice = GetPrice();
        uint256 USD=(ETHPrice* ETH)/(10**18);
        return USD;
    }

     function GetVersion() public view returns (uint256)
    {
        AggregatorV3Interface PriceFeed =  AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return PriceFeed.version();
    }
}