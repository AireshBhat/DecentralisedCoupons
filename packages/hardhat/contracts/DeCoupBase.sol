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
    event Mint(address indexed generator, address indexed sink, uint256 couponId);

    /// @dev Transfer event as defined in current draft of ERC721. Emitted every time a coupon
    ///  ownership is assigned, including creations.
    event Transfer(address indexed from, address indexed to, uint256 couponId);

    /// @dev Approve event which is fired when a sink has approved the coupon sent by the generator.
    event Approve(address indexed generator, address indexed sink, uint256 couponId);

    /// @dev Event that is fired when the coupon has been successfully redeemed by the consumer.
    event RedeemSuccess(uint256 couponId);

    struct Coupon {
        // Coupon design address
        string couponDesignURL;
        // current owner of the coupon
        address owner;
        // The creator of the coupon.
        address generator;
        // The approver of the coupon. The address giving the offer.
        address sink;
        // id of the coupon in Coupons array
        uint256 id;
        // The minimum timestamp period for which the coupons is valid. Starts from when the coupon
        // is transferred from the generator to the user. i.e. Time from when coupon validity starts to
        // coupon validity + couponeValidtyTime
        uint64 couponValidityTime;
        // Stores the start time for the coupon. From when it is valid.
        uint64 couponValidtyStartTime;
        // Coupon Type
        uint8 couponType;
        // Amount of amount left to be redeemed
        uint8 amountRedeemable;
        // Coupon Status
        bool isCouponValid;
        // Has Coupon been approved by sink
        bool isCouponApproved;
    }

    /*** STORAGE ***/
    Coupon[] coupons;

    // Address of valid generators and sinks
    mapping(address => bool) generators;
    mapping(address => bool) sinks;

    /*** CONSTANTS ***/

    /// @dev A lookup table indicating the validityTime duration.
    uint32[14] public validityTime = [
        uint32(1 minutes),
        uint32(2 minutes),
        uint32(5 minutes),
        uint32(10 minutes),
        uint32(30 minutes),
        uint32(1 hours),
        uint32(2 hours),
        uint32(4 hours),
        uint32(8 hours),
        uint32(16 hours),
        uint32(1 days),
        uint32(2 days),
        uint32(4 days),
        uint32(7 days)
    ];
}
