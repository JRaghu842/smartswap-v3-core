// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

import "../libraries/TickMath.sol";

import "../interfaces/callback/ISmartSwapSwapCallback.sol";

import "../interfaces/ISmartSwapPool.sol";

contract TestSmartSwapReentrantCallee is ISmartSwapSwapCallback {
    string private constant expectedReason = "LOK";

    function swapToReenter(address pool) external {
        ISmartSwapPool(pool).swap(
            address(0),
            false,
            1,
            TickMath.MAX_SQRT_RATIO - 1,
            new bytes(0)
        );
    }

    function smartSwapSwapCallback(
        int256,
        int256,
        bytes calldata
    ) external override {
        // try to reenter swap
        try
            ISmartSwapPool(msg.sender).swap(
                address(0),
                false,
                1,
                0,
                new bytes(0)
            )
        {} catch Error(string memory reason) {
            require(
                keccak256(abi.encode(reason)) ==
                    keccak256(abi.encode(expectedReason))
            );
        }

        // try to reenter mint
        try
            ISmartSwapPool(msg.sender).mint(address(0), 0, 0, 0, new bytes(0))
        {} catch Error(string memory reason) {
            require(
                keccak256(abi.encode(reason)) ==
                    keccak256(abi.encode(expectedReason))
            );
        }

        // try to reenter collect
        try
            ISmartSwapPool(msg.sender).collect(address(0), 0, 0, 0, 0)
        {} catch Error(string memory reason) {
            require(
                keccak256(abi.encode(reason)) ==
                    keccak256(abi.encode(expectedReason))
            );
        }

        // try to reenter burn
        try ISmartSwapPool(msg.sender).burn(0, 0, 0) {} catch Error(
            string memory reason
        ) {
            require(
                keccak256(abi.encode(reason)) ==
                    keccak256(abi.encode(expectedReason))
            );
        }

        // try to reenter flash
        try
            ISmartSwapPool(msg.sender).flash(address(0), 0, 0, new bytes(0))
        {} catch Error(string memory reason) {
            require(
                keccak256(abi.encode(reason)) ==
                    keccak256(abi.encode(expectedReason))
            );
        }

        // try to reenter collectProtocol
        try
            ISmartSwapPool(msg.sender).collectProtocol(address(0), 0, 0)
        {} catch Error(string memory reason) {
            require(
                keccak256(abi.encode(reason)) ==
                    keccak256(abi.encode(expectedReason))
            );
        }

        require(false, "Unable to reenter");
    }
}
