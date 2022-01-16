pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

/// @title A facet of DeCoup that manages special access privileges.
/// @author Shekhar Somani
import "./ApproveCoupon.sol";

contract TransferOwner is ApproveCoupon {
    function _transferToUser(uint256 _couponId, address _targetUser)
        internal
        isValidCoupon(_couponId)
        isApprovedCoupon(_couponId)
        isOwnedBy(_couponId)
    {
        if (
            coupons[_couponId].couponValidityTime +
                coupons[_couponId].couponCreationTime <
            block.timestamp
        ) {
            coupons[_couponId].isCouponValid = false;
        }
        coupons[_couponId].owner = _targetUser;
        emit Transfer(msg.sender, _targetUser, _couponId);
    }
}
