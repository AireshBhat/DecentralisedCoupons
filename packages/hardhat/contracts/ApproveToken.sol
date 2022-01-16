pragma solidity ^0.8.0;

import "./CouponHelper.sol";

contract ApproveToken is CouponHelper{
    function approveToken(uint _couponId) {
        require(coupons[_couponId].isCouponValid==false);
        coupons[_couponId].isCouponValid = true;
        coupons[_couponId].couponCreationTime = now;
        emit Approve(coupons[_couponId].owner, _couponId);
    }
}
