pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "./CouponHelper.sol";

contract ApproveToken is CouponHelper {
    function approveToken(uint256 _couponId) internal {
        require(coupons[_couponId].isCouponValid == false);

        // check if sender is a valid sink
        require(sinks[msg.sender] == true);

        // check if sender is the assigned sink of the token
        require(coupons[_couponId].sink == msg.sender);

        // check if the current owner is the generatory; can only be approved when the owner is still the generator
        require(generators[coupons[_couponId].owner] == true);

        coupons[_couponId].isCouponValid = true;
        coupons[_couponId].couponCreationTime = uint64(block.timestamp);
        emit Approve(coupons[_couponId].owner, _couponId);
    }
}
