pragma solidity >=0.8.0 <0.9.0;

import "./DeCoupBase.sol";

contract CouponHelper is DeCoupBase {
    // add your helper functions here

    modifier isValidCoupon(Coupon memory _coupon) {
        require(_coupon.isCouponValid);
        _;
    }

    modifier isApprovedCoupon(Coupon memory _coupon) {
        require(_coupon.isCouponApproved);
        _;
    }
}
