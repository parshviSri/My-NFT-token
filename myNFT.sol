// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
 interface IERC721 {
      function balanceOf(address owner) external view returns (uint balance);
      function ownerOf(uint tokenId) external view returns (address owner);
      function transferFrom(
        address from,
        address to,
        uint tokenId
    ) external;
    function approve(address to, uint tokenId) external;
    event Transfer(address indexed from, address indexed to, uint indexed tokenId);
    event Approval(address indexed owner,address indexed approved,uint indexed tokenId);

 }

 contract MyNFT is IERC721{
     mapping(address => uint) _balance;
     mapping(uint => address) _owner;
     // mapping  which owner has approved which token id to which sender
     mapping(address=> mapping(uint => address))_ownerApproval;
     // check how many tokens owner has
    function balanceOf(address owner) external view returns (uint balance){
        return _balance[owner]
    }
    // who is the owner of the token
      function ownerOf(uint tokenId) external view returns (address owner){
          return _owner[tokenId];
      }
      function transferFrom(
        address from,
        address to,
        uint tokenId
    ) external{
        require( from == msg.sender, "Not owner");
        require(_owner[tokenId] == msg.sender , " Token does not exist in your account");
        _balance[from] -=1;
        _owner[tokenId] = to;
        emit transfer(from,to,tokenId);
    }
    function approve(address to, uint tokenId) external{
         require(_owner[tokenId] == msg.sender , " Token does not exist in your account");
         _ownerApproval[msg.sender][_to]=tokenId;
         emit Approval(msg.sender, to, tokenId);

    }

 }
