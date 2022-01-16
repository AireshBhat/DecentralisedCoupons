pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "./CouponHelper.sol";

/// @title Contract to create new Coupons as NFTs.
/// @author Surya Vamsee
contract CreateCoupon is CouponHelper {
    /// @dev funcion to create a Single coupon for generators
    function createCoupon(
        string memory couponDesignURL,
        address sink,
        uint64 couponValidityTime,
        uint64 couponCreationTime,
        uint8 couponType,
        uint8 amountRedeemable,
        bool isCouponValid,
        bool isCouponApproved
    ) public isSink(sink) isGenerator(msg.sender) {
        //Create a new coupon and push it to the coupons array
        uint256 _couponId = coupons.length;
        coupons.push(
            Coupon(
                couponDesignURL,
                0x0000000000000000000000000000000000000000,
                msg.sender,
                sink,
                coupons.length,
                couponValidityTime,
                couponCreationTime,
                couponType,
                amountRedeemable,
                isCouponValid,
                isCouponApproved
            )
        );
        //emit event once the coupon has been created
        emit Mint(msg.sender, _couponId);
    }
}
