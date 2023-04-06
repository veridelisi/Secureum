// SPDX-License-Identifier: MIT
// @author Jesper Kristensen (@cryptojesperk)
pragma solidity 0.8.7;

contract StorageLayout {
    uint x = 2;
    mapping(uint => uint) m;

    function addToM(uint key, uint value) public {
        m[key] = value;
    }

    // HELPER TO READ FROM STORAGE SLOTS
    function readStorageSlot(uint256 i) public view returns (bytes32 content) {
        assembly {
            content := sload(i)
        }
    }

    // HELPER TO GET THE SLOT INDEX OF A MAPPING'S VALUE UNDER IT'S GIVEN KEY
    function getLocationOfMapping(uint mappingSlot, uint key) public pure returns (uint slot) {
        // mappingSlot: the slot that the mapping itself sits in -> here: it's slot 1
        // slot: the slot that the value will be sitting in, e.g.: m[key] = value --> value will sit in "slot."
        return uint256(keccak256(abi.encode(key, mappingSlot)));
    }
}
