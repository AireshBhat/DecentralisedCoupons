pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
import "./DeCoupBase.sol";

/// @title Contract to create new Coupons as NFTs.
/// @author Surya Vamsee
contract createCoupon is DeCoupBase {

    /// @dev funcion to create a Single coupon for generators
    function createCoupon(string couponDesignURL, address sink, uint64 couponValidityTime, uint64 couponCreationTime, uint8 couponType, uint8 amountRedeemable) public {
        require(generators[msg.sender]);
        uint256 id  = coupons.push(Coupon(couponDesignURL, msg.sender, sink, couponValidityTime, couponCreationTime, couponType, amountRedeemable, false, false));
        couponIndexToOwner[id] = msg.sender;
        ownershipCouponCount[msg.sender] = ownershipCouponCount[msg.sender] + 1;
        ownerToCouponIndex[msg.sender].push(id);
        event Mint(msg.sender, id);
    }
}