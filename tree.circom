pragma circom 2.0.0;

include "circuits/utils.circom";
include "circuits/merkle.circom";
//make sure to include these libraries in the cargo.toml file

template MerkleTree() {
  signal leaves[256];
  signal index;
  signal root;
  signal path[256];

  component arrayLength = ArrayLength(256)();
  component merkleTree = MerkleTree(256)();

  merkleTree.input.leaves <== leaves;
  merkleTree.input.index <== index;
  root <== merkleTree.output.root;
  path <== merkleTree.output.path;

  // Constraints
  enforceArrayConstraint(leaves);
  enforceIntegerConstraint(index, 0, arrayLength.output);
  enforceIntegerConstraint(root);
  enforceArrayConstraint(path);
}

component main = MerkleTree();
