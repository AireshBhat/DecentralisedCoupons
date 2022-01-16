pragma solidity >=0.8.0 <0.9.0;

import "./DeCoupBase.sol";
import "./CouponHelper.sol";

// check if user is owner of the coupon
// update the coupon
// return the updated token back
contract RedeemCoupon is CouponHelper {
    function redeemCoupon(uint _couponId, uint8 _amountToBeRedeemed)
        public
        view
        isApprovedCoupon(_couponId)
        isValidCoupon(_couponId)
    {
        // check if the coupon is owned by the sender
        require(coupons[_couponId].owner == msg.sender);
        _updateToken(_couponId, _amountToBeRedeemed);
    }

    // check for coupon type
    //  1. if coupon is percentage type
    //      i. set as invalid
    //  2. if coupon is amount type
    //      i. reduce amount redemeed from total redeemable
    //      ii. if remaining amount is == 0; mark as invalid
    //      iii. if remaining amount is < 0; throw error since the amount
    //              being redeemed is more than remaining amount
    function _updateToken(uint _couponId, uint8 _amountToBeRedeemed)
        private
        pure
        isApprovedCoupon(_couponId)
        isValidCoupon(_couponId)
    {
        require(coupons[_couponId].couponType == 0 || coupons[_couponId].couponType == 1);

        if (coupons[_couponId].couponType == 0) {
            // percentage type coupon
            coupons[_couponId].isCouponValid = false;
        } else {
            // amount type coupon
            require(coupons[_couponId].amountRedeemable - _amountToBeRedeemed >= 0);
            if (coupons[_couponId].amountRedeemable - _amountToBeRedeemed == 0) {
                coupons[_couponId].isCouponValid = false;
            }
            coupons[_couponId].amountRedeemable = coupons[_couponId].amountRedeemable - _amountToBeRedeemed;
        }
    }
}
