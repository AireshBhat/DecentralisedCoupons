pragma solidity >=0.8.0 <0.9.0;

import "./DeCoupBase.sol";
import "./CouponHelper.sol";

// check if user is owner of the coupon
// update the coupon
// return the updated token back
contract RedeemCoupon is CouponHelper {
    function redeemCoupon(Coupon calldata _coupon, uint8 _amountToBeRedeemed)
        public
        view
        isApprovedCoupon(_coupon)
        isValidCoupon(_coupon)
        returns (Coupon memory)
    {
        // check if the coupon is owned by the sender
        require(_coupon.owner == msg.sender);
        
        Coupon memory updatedCoupon = _updateToken(_coupon, _amountToBeRedeemed);
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
    function _updateToken(Coupon calldata _coupon, uint8 _amountToBeRedeemed)
        private
        pure
        isApprovedCoupon(_coupon)
        isValidCoupon(_coupon)
        returns (Coupon memory)
    {
        require(_coupon.couponType == 0 || _coupon.couponType == 1);
        
        Coupon memory updatedCoupon = _coupon;

        if (_coupon.couponType == 0) {
            // percentage type coupon
            updatedCoupon.isCouponValid = false;
        } else {
            // amount type coupon
            require(_coupon.amountRedeemable - _amountToBeRedeemed >= 0);
            if (_coupon.amountRedeemable - _amountToBeRedeemed == 0) {
                updatedCoupon.isCouponValid = false;
            }
            updatedCoupon.amountRedeemable = _coupon.amountRedeemable - _amountToBeRedeemed;
        }
        return updatedCoupon;
    }
}
