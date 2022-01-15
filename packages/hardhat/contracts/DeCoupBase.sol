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
    event Mint(address owner, uint256 couponId);

    /// @dev Transfer event as defined in current draft of ERC721. Emitted every time a coupon
    ///  ownership is assigned, including creations.
    event Transfer(address from, address to, uint256 tokenId);

    struct Coupon {
        // Coupon design address
        string couponDesignURL;

        // The creator of the coupon.
        address generator;

        // The approver of the coupon. The address giving the offer.
        address sink;

        // The minimum timestamp period for which the coupons is valid. Starts from when the coupon
        // is transferred from the generator to the user. i.e. Time from when coupon validity starts to
        // coupon validity + couponeValidtyTime
        uint64 couponValidityTime;

        // Coupon Type
        uint8 couponType;
    }
}