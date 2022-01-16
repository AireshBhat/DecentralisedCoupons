pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "./CreateCoupon.sol";

contract ApproveCoupon is CreateCoupon {
    function approveToken(uint256 _couponId) internal isSink(msg.sender) {
        require(coupons[_couponId].isCouponValid == false);

        // check if sender is a valid sink
        require(sinks[msg.sender] == true);

        // check if sender is the assigned sink of the token
        require(coupons[_couponId].sink == msg.sender);

        // check if the current owner is the generatory; can only be approved when the owner is still the generator
        require(coupons[_couponId].owner == 0x0000000000000000000000000000000000000000);

        coupons[_couponId].isCouponValid = true;
        coupons[_couponId].couponValidtyStartTime = uint64(block.timestamp);
        emit Approve(coupons[_couponId].owner, msg.sender, _couponId);
    }

    // TODO: Add rejectToken functionality
}
