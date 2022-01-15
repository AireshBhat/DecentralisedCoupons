pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
import "./AccessControlContract.sol";

/// @title Base contract for DeCoup. Holds all common structs, events and base variables.
/// @author Airesh Bhat
contract DeCoupBase is AccessControlContract {
    /*** EVENTS ***/

    /// @dev The MintCoupon event is fired whenever a new coupon comes into existence.
    event Mint(address owner, uint256 couponId, );
}