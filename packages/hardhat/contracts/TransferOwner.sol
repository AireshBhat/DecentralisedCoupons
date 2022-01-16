pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "./ApproveCoupon.sol";

/// @title A facet of DeCoup that manages special access privileges.
/// @author Shekhar Somani
contract TransferOwner is ApproveCoupon {
    function _transferToUser(uint256 _couponId, address _targetUser)
        internal
        isCouponValid(_couponId)
        isApprovedCoupon(_couponId)
        isOwnedBy(_couponId)
    {
        if (
            coupons[_couponId].couponValidityTime +
                coupons[_couponId].couponValidtyStartTime <
            block.timestamp
        ) {
            coupons[_couponId].isCouponValid = false;
        } else {
            coupons[_couponId].owner = _targetUser;
            emit Transfer(msg.sender, _targetUser, _couponId);
        }
    }
    // TODO: Add a function to transfer the coupon from user to user
    function _transferFromGenerator(uint256 _couponId, address _targetUser)
    internal
    isCouponValid(_couponId)
    isApprovedCoupon(_couponId)
    isGenerator(msg.sender)
    {
        if (
            coupons[_couponId].couponValidityTime +
            coupons[_couponId].couponValidtyStartTime <
            block.timestamp
        ) {
            coupons[_couponId].isCouponValid = false;
        } else {
            coupons[_couponId].owner = _targetUser;
            emit Transfer(msg.sender, _targetUser, _couponId);
        }
    }}
