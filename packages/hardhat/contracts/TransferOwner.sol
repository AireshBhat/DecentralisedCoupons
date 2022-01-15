pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

/// @title A facet of DeCoup that manages special access privileges.
/// @author Shekhar Somani
import "./CouponHelper.sol";

contract TransferOwner is CouponHelper{

    function _transferToUser(Coupon memory _coupon, address _targetUser)
        internal
        isValidCoupon(_coupon) isApprovedCoupon(_couponId) isOwnedBy(_coupon)
        returns (Coupon memory)
    {
        Coupon _updatedCoupon = _coupon;
        if(_coupon.couponValidityTime + _coupon.couponCreationTime < now){
            _updatedCoupon.isCouponValid = false;
            return _updatedCoupon;
        }
        _updatedCoupon.owner = _targetUser;
        return _updatedCoupon;
    }
}
