// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

import "./pool/ISmartSwapPoolImmutables.sol";
import "./pool/ISmartSwapPoolState.sol";
import "./pool/ISmartSwapPoolDerivedState.sol";
import "./pool/ISmartSwapPoolActions.sol";
import "./pool/ISmartSwapPoolOwnerActions.sol";
import "./pool/ISmartSwapPoolEvents.sol";

/// @title The interface for a SmartSwap  Pool
/// @notice A SmartSwap pool facilitates swapping and automated market making between any two assets that strictly conform
/// to the ERC20 specification
/// @dev The pool interface is broken up into many smaller pieces
interface ISmartSwapPool is
    ISmartSwapPoolImmutables,
    ISmartSwapPoolState,
    ISmartSwapPoolDerivedState,
    ISmartSwapPoolActions,
    ISmartSwapPoolOwnerActions,
    ISmartSwapPoolEvents
{

}
