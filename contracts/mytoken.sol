//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

abstract contract erc20 {
    function name() public view virtual returns (string memory) {}

    function symbol() public view virtual returns (string memory) {}

    function decimals() public view virtual returns (uint8) {}

    function totalSupply() public view virtual returns (uint256) {}

    function balanceOf(
        address _owner
    ) public view virtual returns (uint256 balance) {}

    function transfer(
        address _to,
        uint256 _value
    ) public virtual returns (bool success) {}

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public virtual returns (bool success) {}

    function approve(
        address _spender,
        uint256 _value
    ) public virtual returns (bool success) {}

    function allowance(
        address _owner,
        address _spender
    ) public view virtual returns (uint256 remaining) {}

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}

contract ownereship {
    address public contractowner;
    address public newowner;
    event transferoweneship(address indexed _form, address indexed _to);

    constructor() {
        contractowner = msg.sender;
    }

    function changeOwner(address _to) public {
        require(
            msg.sender == contractowner,
            "only owner of the contract an change the owner"
        );
        newowner = _to;
    }

    function acceptOwner() public {
        require(
            msg.sender == newowner,
            "only the elected owner will have a permission to get the ownership"
        );
        contractowner = newowner;
        emit transferoweneship(contractowner, newowner);
        newowner = address(0);
    }
}

contract shubhamscoin is erc20, ownereship {
    string public _symbol;
    string public _name;
    uint8 public _decimal;
    uint256 public totalsupply;

    address public _minter;

    mapping(address => uint256) public balanceof;
    mapping(address => mapping(address => uint256)) public allowed;

    constructor(address minter_, uint256 _totalsupply) {
        _symbol = "scoin";
        _name = "shubhamscoin";
        _decimal = 0;
        totalsupply = _totalsupply;
        _minter = minter_;

        balanceof[_minter] = _totalsupply;
    }

    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    function decimals() public view override returns (uint8) {
        return _decimal;
    }

    function totalSupply() public view override returns (uint256) {
        return totalsupply;
    }

    function balanceOf(
        address _owner
    ) public view override returns (uint256 balance) {
        return balanceof[_owner];
    }

    function transfer(
        address _to,
        uint256 _value
    ) public override returns (bool success) {
        require(balanceof[msg.sender] >= _value, "Insufficient Balance");
        balanceof[msg.sender] -= _value;
        balanceof[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public override returns (bool success) {
        require(allowed[_from][_to] >= _value, "_value is not allowed");
        balanceof[_from] -= _value;
        balanceof[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(
        address _spender,
        uint256 _value
    ) public override returns (bool success) {
        require(balanceof[msg.sender] >= _value, "Insufficient Balance");
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view override returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}
