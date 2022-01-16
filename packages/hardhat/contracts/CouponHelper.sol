pragma solidity >=0.8.0 <0.9.0;

import "./DeCoupBase.sol";

contract CouponHelper is DeCoupBase {
    // add your helper functions here

    modifier isValidCoupon(uint _couponId) {
        require(coupons[_couponId].isCouponValid);
        require((coupons[_couponId].couponValidityTime + coupons[_couponId].couponCreationTime) >= now);
        _;
    }

    modifier isApprovedCoupon(uint _couponId) {
        require(coupons[_couponId].isCouponApproved);
        _;
    }

    modifier isOwnedBy(uint _couponId) {
        require(coupons[_couponId].owner = msg.sender);
        _;
    }

}
