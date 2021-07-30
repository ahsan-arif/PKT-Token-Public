// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract PKTFactory is ERC20{
     address public owner;
    uint256 private _totalSupply;
    //hold approval allowances of a certain address
    mapping (address => mapping(address => uint256)) private _approvedAllowances;
    mapping (address => uint256) _balanceOf;
    constructor () ERC20("Pakistan Token","PKT") {
        owner = msg.sender;
        //this will generate 1 million tokens
        _totalSupply = 1000000 * 10 ** decimals();
        //transfer all the tokens to the owner
       _mint(msg.sender,_totalSupply);
        _balanceOf[msg.sender] = _totalSupply;
        //emit Transfer(address(this), owner, _totalSupply);
    }

    function decimals() public view virtual override returns (uint8) {
    return 2;
    }

    function totalSupply () public view override returns(uint256){
        return _totalSupply;
    }

    function balanceOf (address account) public view override returns(uint256){
        return _balanceOf[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool){
        address sender = msg.sender;
        require(sender != address(0) , "Transfer: The address of sender is 0");
         require(recipient != address(0) , "Transfer: The address of recipient is 0");
         require(_balanceOf[sender]>amount , "Insufficent balance to carry out transaction");
         //debit balance of sender
         _balanceOf[sender] = _balanceOf[sender] - amount;
         //credit balance of recepient
         _balanceOf[recipient] = _balanceOf[recipient] +amount;
         emit Transfer(sender, recipient, amount);
         return true;
    }
    
    function allowance(address tokenOwner, address spender) public view override returns (uint256){
        return _approvedAllowances[tokenOwner][spender];
    }
    function approve(address spender, uint256 amount) public override returns (bool){
        address tokenOwner = msg.sender;
         require(tokenOwner != address(0) , "Approve: The address of sender is 0");
         require(spender != address(0) , "Approve: The address of recipient is 0");
         //require(_balanceOf[tokenOwner]>amount , "Insufficent balance to carry out transaction");
         _approvedAllowances[tokenOwner][spender] = amount;
         emit Approval(tokenOwner,spender,amount);
         return true;
    }
     function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool){
      //  address spender = msg.sender;
        uint256 _allowedAmount  = _approvedAllowances[sender][recipient];
        require(_allowedAmount >= amount, "Transfer amount exceed allowed amount");
        _allowedAmount = _allowedAmount - amount;
        _balanceOf[sender] = _balanceOf[sender]-amount;
        _balanceOf[recipient] = _balanceOf[recipient] + amount;
        emit Transfer(sender, recipient,amount);
        _approvedAllowances[sender][recipient] = _allowedAmount;
        emit Approval(sender, recipient, amount);
        return true;
    }
}