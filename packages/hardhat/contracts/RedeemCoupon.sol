pragma solidity >=0.8.0 <0.9.0;

import "./DeCoupBase.sol";
import "./CouponHelper.sol";

// check if user is owner of the coupon
// update the coupon
// return the updated token back
contract RedeemCoupon is CouponHelper {
    function redeemCoupon(Coupon calldata _coupon)
        public
        isApprovedCoupon(_coupon)
        isValidCoupon(_coupon)
        returns (Coupon memory)
    {
        // check if the coupon is owned by the sender
        address couponOwner = couponIndexToOwner[_coupon.id];
        require(couponOwner == msg.sender);
        
        Coupon memory updatedCoupon = _updateToken(_coupon);
        return updatedCoupon;
    }

    // check for coupon type
    //  1. if coupon is percentage type
    //      i. set as invalid
    //  2. if coupon is amount type
    //      i. reduce amount redemeed from total redeemable
    //      ii. if remaining amount is == 0; mark as invalid
    //      iii. if remaining amount is < 0; throw error since the amount
    //              being redeemed is more than remaining amount
    function _updateToken(Coupon calldata _coupon)
        private
        isApprovedCoupon(_coupon)
        isValidCoupon(_coupon)
        returns (Coupon memory)
    {
        require(_coupon.couponType == 0 || _coupon.couponType == 1);

        Coupon memory updatedCoupon = _coupon;
        if (_coupon.couponType == 0) {
            // percentage type coupon
            updatedCoupon.isCouponValid = false;
            return updatedCoupon;
        } else if (_coupon.couponType == 1) {
            // amount type coupon
        } else {
            // throw error for now
        }
    }
}
