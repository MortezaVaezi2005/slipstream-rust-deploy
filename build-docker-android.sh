#!/bin/bash
set -e

cd /workspace

if [ ! -d "slipstream-rust" ]; then
    echo "ERROR: slipstream-rust directory not found. It should be mounted as a volume."
    exit 1
fi

cd slipstream-rust

echo "Building slipstream binaries for aarch64-linux-android..."

# Set environment variables for picoquic
export PICOQUIC_DIR=/workspace/slipstream-rust/vendor/picoquic
export PICOQUIC_BUILD_DIR=/workspace/slipstream-rust/.picoquic-build
export PICOQUIC_FETCH_PTLS=ON
export PICOQUIC_AUTO_BUILD=1

# Ensure target is added (though cross-rs image should handle it, we want to be safe)
rustup target add aarch64-linux-android

# We need to use -p to build specific packages, and openssl-vendored feature is crucial for Android
cargo build --release --target aarch64-linux-android -p slipstream-client -p slipstream-server --features openssl-vendored

mkdir -p /workspace/output
cp target/aarch64-linux-android/release/slipstream-client /workspace/output/
cp target/aarch64-linux-android/release/slipstream-server /workspace/output/

echo "Build complete! Binaries are in /workspace/output/"
