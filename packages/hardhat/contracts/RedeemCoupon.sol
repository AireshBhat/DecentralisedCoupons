pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "./TransferOwner.sol";

// check if user is owner of the coupon
// update the coupon
// return the updated token back
contract RedeemCoupon is TransferOwner {
    function redeemCoupon(uint256 _couponId, uint8 _amountToBeRedeemed)
        public
        isApprovedCoupon(_couponId)
        isCouponValid(_couponId)
        isCouponExpired(_couponId)
        isCouponTypeValid(coupons[_couponId].couponType)
        {
        // check if the coupon is owned by the sender
        require(coupons[_couponId].sink == msg.sender);

        // check for coupon type
        //  1. if coupon is percentage type
        //      i. set as invalid
        //  2. if coupon is amount type
        //      i. reduce amount redemeed from total redeemable
        //      ii. if remaining amount is == 0; mark as invalid
        //      iii. if remaining amount is < 0; throw error since the amount
        //              being redeemed is more than remaining amount

        if (coupons[_couponId].couponType == 0) {
            // percentage type coupon
            coupons[_couponId].isCouponValid = false;
        } else {
            // amount type coupon
            require(
                coupons[_couponId].amountRedeemable - _amountToBeRedeemed >= 0
            );
            if (
                coupons[_couponId].amountRedeemable - _amountToBeRedeemed == 0
            ) {
                coupons[_couponId].isCouponValid = false;
            }
            coupons[_couponId].amountRedeemable =
                coupons[_couponId].amountRedeemable -
                _amountToBeRedeemed;
        }
        emit RedeemSuccess(_couponId);
    }

}
