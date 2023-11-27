// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/ERC20.sol";



contract Token is ERC20 {

    constructor(string memory _name, string memory _symbol)
      ERC20(_name, _symbol)
    {}

     function mint(address account,uint _amount) external {
       _mint(account,_amount);
    }
    // Function to burn tokens from a user's balance
    function burn(address account,uint _amount) external{
        _burn(account,_amount);
    }

}


contract TokenScript is Script {
    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint("DEV_PRIVATE_KEY");

        address account = vm.addr(privateKey);

        console.log("Account", account);

        vm.startBroadcast(privateKey);
        // deploy token
        Token token = new Token("Test Foundry", "TEST");
        // mint
        token.mint(account, 300);
        vm.stopBroadcast();
    }
}

///  command :  forge script .\script\Token.s.sol:TokenScript --rpc-url https://eth-sepolia.g.alchemy.com/v2/WKPkDrLeOv3CGw6Am6poh_SRjiyMfpUi --broadcast --verify -vvvv
