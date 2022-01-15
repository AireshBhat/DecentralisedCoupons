pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
import "./DeCoupBase.sol";

/// @title Contract to create new Coupons as NFTs.
/// @author Surya Vamsee
contract createCoupon is DeCoupBase {

    /// @dev funcion to create a Single coupon for generators
    function createCoupon(string couponDesignURL, uint id, address sink, uint64 couponValidityTime, uint64 couponCreationTime, uint8 couponType, uint8 amountRedeemable, bool isCouponValid, bool isCouponApproved) public {
        require(generators[msg.sender]);
        uint256 id  = coupons.push(Coupon(couponDesignURL, coupons.length() + 1, msg.sender, sink, couponValidityTime, couponCreationTime, couponType, amountRedeemable, false, false));
        event Mint(msg.sender, id);
    }
}