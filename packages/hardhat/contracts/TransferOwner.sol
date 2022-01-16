pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

/// @title A facet of DeCoup that manages special access privileges.
/// @author Shekhar Somani
import "./CouponHelper.sol";

contract TransferOwner is CouponHelper{

    function _transferToUser(uint _couponId, address _targetUser)
        internal
        isValidCoupon(_couponId) isApprovedCoupon(_couponId) isOwnedBy(_couponId)
    {
        if(coupons[_couponId].couponValidityTime + coupons[_couponId].couponCreationTime < now){
            coupons[_couponId].isCouponValid = false;
        }
        coupons[_couponId].owner = _targetUser;
    }
}
