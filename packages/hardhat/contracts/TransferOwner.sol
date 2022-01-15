pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

/// @title A facet of DeCoup that manages special access privileges.
/// @author Shekhar Somani
import "./DeCoupBase.sol";

contract TransferOwner is DeCoupBase{
    function _transferToUser(uint _couponId,address _targetUser) internal couponTimeValid{
        //what all I have to change
        //change it in the couponIndexToOwner
        couponIndexToOwner[_couponId] = _targetUser;
        //check if a user already has coupons
        if(ownershipCouponCount[_targetUser]){
            ownershipCouponCount[_targetUser]++;
        }else
        {
            ownershipCouponCount.push(_targetUser,1);
        }
        //reduce the coupon for the owner
        ownershipCouponCount[msg.sender]--;
        //change the index in the ownerToCouponIndex
        -_ownerToCouponIndexUpdater(_couponId,_targetUser);


    }

    function _ownerToCouponIndexUpdater(uint _couponId,address _targetUser) internal {
        //change the address of the new owner
        ownerToCouponIndex[_targetUser].push(_couponId);
        //change the address of the older user
        _deleteTheCoupon(_couponId);
    }

    function _deleteTheCoupon(uint _couponId){
        uint[] result;
        uint counter=0;
        for(uint i=0;i<ownerToCouponIndex[msg.sender];i++){
            if(ownerToCouponIndex[msg.sender][i] != _couponId){
                result.push(ownerToCouponIndex[msg.sender][i]);
                counter++;
            }
        }
        ownerToCouponIndex[msg.sender]=result;
    }

    modifier couponTimeValid(uint _couponId){
        require(coupons[_couponId].couponValidityTime >= now);
        _;
    }

}