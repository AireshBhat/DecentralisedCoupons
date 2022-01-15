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
    mapping (address => bool) generators;
    mapping (address => bool) sinks;

    // Owner address to coupon index mapping.
    mapping (address => uint[]) ownerToCouponIndex;

    /// @dev A mapping from coupon IDs to the address that owns them. All coupons have
    ///  some valid owner address.
    mapping (uint256 => address) public couponIndexToOwner;

    // @dev A mapping from owner address to count of tokens that address owns.
    //  Used internally inside balanceOf() to resolve ownership count.
    mapping (address => uint256) ownershipCouponCount;

    /// @dev A mapping from CouponIDs to an address that has been approved to call
    ///  transferFrom(). Each Coupon can only have one approved address for transfer
    ///  at any time. A zero value means no approval is outstanding.
    mapping (uint256 => address) public kittyIndexToApproved;

}