
pragma solidity ^0.6.6;

contract Storage{

    int num;

    struct man{
        string name;
        int money;
    }
    man[] public men;
    mapping(string => int ) public name_money;

    function Store(string memory name, int money) public {
            men.push(man(name,money));
    }

}