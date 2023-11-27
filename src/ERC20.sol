// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

// Interface for ERC20 token standard
interface IERC20{
    // Returns the total supply of tokens
    function totalSupply() external view returns (uint);
    // Returns the balance of the specified `_account`
    function balanceOf(address _account) external view returns (uint balance);
    // Transfers `_value` tokens from the caller to `_to` address
    function transfer(address _to, uint _value) external returns (bool success);
    // Returns the allowed amount of tokens a spender is allowed to spend on behalf of the owner
    function allowances(address _owner, address _spender) external view returns(uint);
    // Approves the `_spender` to spend `_amount` tokens on behalf of the owner
    function approve(address _spender, uint _amount) external returns(bool);
    // Transfers `_amount` tokens from `_from` to `_to` address
    function transferFrom(address _from, address _to, uint _amount) external returns(bool);
    // Event triggered on token transfer
    event Transfer(address from, address to, uint amount);
    // Event triggered on approval of spender to spend tokens on behalf of owner
    event Approve (address owner, address spender, uint amount);
}
contract ERC20 is IERC20{
    // Name of the token
    string public name;
    // Symbol of the token
    string public symbol;
    // Total supply of the token
    uint public totalSupply;

    // Mapping to store the balance of each address
    mapping(address => uint) public balanceOf;
    // Mapping to store the approved amounts for an address
    mapping(address => mapping(address => uint)) public allowances;
    // Constructor to initialize the name and symbol of the token
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }
    // Function to return the number of decimal places used by the token
    function decimals() public view virtual returns (uint8) {
        return 18;
    }
    // This function allows the transfer of tokens from one address to another
    function transfer(address _to, uint _value) external returns (bool) {
        // Increase the balance of the receiving address
        balanceOf[_to] += _value;
        // Decrease the balance of the sending address
        balanceOf[msg.sender] -= _value;
        // Emit a Transfer event with the sender, receiver, and amount of tokens transferred
        emit Transfer(msg.sender, _to, _value);
        // Return true to indicate a successful transfer
        return true;
    }
    // Function to approve an address to spend an amount from the msg.sender's balance
    function approve(address _spender, uint _value) external returns(bool){
        // Set the approved amount for the spender
        allowances[msg.sender][_spender] = _value;
        // Emit the Approve event, with the msg.sender, spender and value
        emit Approve(msg.sender, _spender, _value);
        // Return true to indicate the approval was successful
        return true;
    }

    // Function to transfer token from one address to another
    function transferFrom(address _from, address _to, uint _amount) external returns(bool) {
        // Decrease the allowance of the sender from the caller
        allowances[_from][msg.sender] -= _amount;
        // Decrease the balance of the sender
        balanceOf[_from] -= _amount;
        // Increase the balance of the recipient
        balanceOf[_to] += _amount;
        // Emit an event to track the transfer
        emit Transfer(_from, _to, _amount);
        // Return true to indicate success
        return true;
    }
    // This function allows a user to mint a specified amount of tokens.
    function _mint(address _account,uint _amount) internal {
        // Update the balance of the user who is calling the function
        balanceOf[_account] += _amount;
        // Update the total supply of the tokens
        totalSupply += _amount;
        // Emit an event to notify that a transfer has taken place
        emit Transfer(address(0), msg.sender, _amount);
    }
    // Function to burn tokens from a user's balance
    function _burn(address _account,uint _amount) internal{
        // Decrement the sender's balance by the specified amount
        balanceOf[_account] -= _amount;
        // Decrement the total supply by the specified amount
        totalSupply -= _amount;
        // Emit a Transfer event to log the token burn
        emit Transfer(msg.sender, address(0), _amount);
    }
}