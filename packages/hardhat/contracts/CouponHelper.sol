pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "./DeCoupBase.sol";

contract CouponHelper is DeCoupBase {
    // add your helper functions here

    modifier isCouponExpired(uint256 _couponId) {
        // check if coupon validity has expired
        require(
            (coupons[_couponId].couponValidityTime +
                coupons[_couponId].couponValidtyStartTime) >= block.timestamp
        );
        _;
    }

    modifier isCouponValid(uint256 _couponId) {
        // check validity flag
        require(coupons[_couponId].isCouponValid);
        _;
    }

    modifier isApprovedCoupon(uint256 _couponId) {
        require(coupons[_couponId].isCouponApproved);
        _;
    }

    modifier isOwnedBy(uint256 _couponId) {
        require(coupons[_couponId].owner == msg.sender);
        _;
    }

    modifier isSink(address _address) {
        require(sinks[_address] == true);
        _;
    }

    modifier isGenerator(address _address) {
        require(generators[_address] == true);
        _;
    }

    modifier isCouponTypeValid(uint couponType) {
        require(
            couponType == 0 ||
            couponType == 1
        );
        _;
    }

    function addGenerator(address generator) public onlyCEO {
        generators[generator] = true;
    }

    function removeGenerator(address generator) public onlyCEO {
        generators[generator] = false;
    }

    function addSetter(address sink) public onlyCEO {
        sinks[sink] = true;
    }

    function removeSetter(address sink) public onlyCEO {
        sinks[sink] = false;
    }
}
