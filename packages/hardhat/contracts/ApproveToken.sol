pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "./CouponHelper.sol";

contract ApproveToken is CouponHelper {
    function approveToken(uint256 _couponId) internal {
        require(coupons[_couponId].isCouponValid == false);
        coupons[_couponId].isCouponValid = true;
        coupons[_couponId].couponCreationTime = uint64(block.timestamp);
        emit Approve(coupons[_couponId].owner, _couponId);
    }
}
