// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    // require
    // revert
    // assert
    address owner;

    mapping (uint8 => bool) public MyMapping;

    struct MyStruct {
        uint timestamp;
        address user;
    }

    MyStruct public StorageMyStruct;

    event Paid(address indexed _from, uint _amount, uint _timestamp);

    // function trueMapping() public {
    //     MyMapping[2] = 1;
    // }

    function changeState(uint8 num) public {
        MyMapping[num] =! MyMapping[num];
        MyStruct memory newMyStruct = MyStruct(
            block.timestamp,
            msg.sender
        );
        StorageMyStruct = newMyStruct;
    }

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        pay();
    }

    function pay() public payable {
        emit Paid(msg.sender, msg.value, block.timestamp);
    }

    modifier onlyOwner(address _to) {
        require(msg.sender == owner, "you are not an owner!");
        require(_to != address(0), "incorrect address!");
        _;
        //require(...);
    }

    function withdraw(address payable _to) external onlyOwner(_to) {
        // Panic
        // assert(msg.sender == owner);
        // Error
        // require(msg.sender == owner, "you are not an owner!");
        // if(msg.sender == owner) {
        //     revert("you are not an owner!");
        // } else {}
        
        _to.transfer(address(this).balance);
    }
}