pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "./CreateCoupon.sol";

contract ApproveCoupon is CreateCoupon {
    function approveCoupon(uint256 _couponId) internal isSink(msg.sender) {
        require(coupons[_couponId].isCouponValid == false);

        // check if sender is the assigned sink of the token
        require(coupons[_couponId].sink == msg.sender);

        // check if there is no current owner; can only be approved when the coupon has not been transfered by generator
        require(
            coupons[_couponId].owner ==
                0x0000000000000000000000000000000000000000
        );

        coupons[_couponId].isCouponValid = true;
        coupons[_couponId].couponValidtyStartTime = uint64(block.timestamp);
        emit ApproveResponse(
            coupons[_couponId].generator,
            msg.sender,
            _couponId,
            true
        );
    }

    function rejectCoupon(uint256 _couponId) internal isSink(msg.sender) {
        require(coupons[_couponId].isCouponValid == false);

        // check if sender is the assigned sink of the token
        require(coupons[_couponId].sink == msg.sender);

        // check if there is no current owner; can only be approved when the coupon has not been transfered by generator
        require(
            coupons[_couponId].owner ==
                0x0000000000000000000000000000000000000000
        );

        coupons[_couponId].isCouponValid = false;
        coupons[_couponId].isCouponApproved = false;
        emit ApproveResponse(
            coupons[_couponId].generator,
            msg.sender,
            _couponId,
            false
        );
    }
}
